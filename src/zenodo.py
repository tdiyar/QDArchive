from __future__ import annotations

import html
import re
import sqlite3
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass, field
from datetime import datetime, timezone
from pathlib import Path

import requests
from tqdm import tqdm


API_BASE = "https://zenodo.org/api"
REPOSITORY_ID = 1
REPOSITORY_URL = "https://zenodo.org"
MAX_DOWNLOAD_SIZE = 10 * 1024 * 1024  # 10 MB

_ROLE_MAP = {"uploader": "UPLOADER", "author": "AUTHOR", "owner": "OWNER"}


@dataclass(frozen=True)
class Config:
    queries: list[str]
    limit: int | None
    workers: int
    db_path: Path
    download_root: Path
    no_download: bool
    page_size: int = 25
    timeout: int = 30
    delay: float = 0.1


def _strip_html(text: str | None) -> str:
    if not text:
        return ""
    return re.sub(r"\s+", " ", re.sub(r"<[^>]+>", " ", html.unescape(text))).strip()


def _ext(name: str) -> str:
    return name.rsplit(".", 1)[-1].lower() if "." in name else ""


def _map_role(raw: str | None) -> str:
    return _ROLE_MAP.get((raw or "").lower(), "OTHER")


def _create_tables(conn: sqlite3.Connection) -> None:
    conn.executescript("""
        CREATE TABLE IF NOT EXISTS PROJECTS (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            query_string TEXT,
            repository_id INTEGER NOT NULL,
            repository_url TEXT NOT NULL,
            project_url TEXT NOT NULL UNIQUE,
            version TEXT,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            language TEXT,
            doi TEXT,
            upload_date TEXT,
            download_date TEXT NOT NULL,
            download_repository_folder TEXT NOT NULL,
            download_project_folder TEXT NOT NULL,
            download_version_folder TEXT,
            download_method TEXT NOT NULL
        );
        CREATE TABLE IF NOT EXISTS FILES (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            project_id INTEGER NOT NULL,
            file_name TEXT NOT NULL,
            file_type TEXT NOT NULL,
            status TEXT NOT NULL,
            UNIQUE(project_id, file_name),
            FOREIGN KEY(project_id) REFERENCES PROJECTS(id)
        );
        CREATE TABLE IF NOT EXISTS KEYWORDS (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            project_id INTEGER NOT NULL,
            keyword TEXT NOT NULL,
            UNIQUE(project_id, keyword),
            FOREIGN KEY(project_id) REFERENCES PROJECTS(id)
        );
        CREATE TABLE IF NOT EXISTS PERSON_ROLE (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            project_id INTEGER NOT NULL,
            name TEXT NOT NULL,
            role TEXT NOT NULL,
            UNIQUE(project_id, name, role),
            FOREIGN KEY(project_id) REFERENCES PROJECTS(id)
        );
        CREATE TABLE IF NOT EXISTS LICENSES (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            project_id INTEGER NOT NULL,
            license TEXT NOT NULL,
            UNIQUE(project_id, license),
            FOREIGN KEY(project_id) REFERENCES PROJECTS(id)
        );
    """)
    conn.commit()


def _upsert_project(conn: sqlite3.Connection, query: str, record: dict, download_root: Path) -> int:
    meta = record.get("metadata", {})
    rec_id = str(record["id"])
    project_url = record.get("links", {}).get("self_html") or f"{REPOSITORY_URL}/records/{rec_id}"
    doi = record.get("doi_url") or record.get("links", {}).get("doi")
    pub_date = (meta.get("publication_date") or record.get("created", ""))[:10] or None

    conn.execute("""
        INSERT OR IGNORE INTO PROJECTS (
            query_string, repository_id, repository_url, project_url, version,
            title, description, language, doi, upload_date, download_date,
            download_repository_folder, download_project_folder, download_version_folder, download_method
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
    """, (
        query, REPOSITORY_ID, REPOSITORY_URL, project_url,
        meta.get("version"),
        record.get("title") or meta.get("title") or "",
        _strip_html(meta.get("description")),
        meta.get("language"),
        doi,
        pub_date,
        datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "zenodo",
        rec_id,
        meta.get("version"),
        "API-CALL",
    ))
    return conn.execute("SELECT id FROM PROJECTS WHERE project_url=?", (project_url,)).fetchone()[0]


def _insert_keywords(conn: sqlite3.Connection, pid: int, meta: dict) -> None:
    for item in meta.get("keywords") or []:
        for kw in str(item).split(","):
            kw = kw.strip()
            if kw:
                conn.execute("INSERT OR IGNORE INTO KEYWORDS(project_id, keyword) VALUES (?,?)", (pid, kw))


def _insert_people(conn: sqlite3.Connection, pid: int, meta: dict) -> None:
    for p in meta.get("creators") or []:
        name = p.get("name") if isinstance(p, dict) else str(p)
        if name:
            conn.execute("INSERT OR IGNORE INTO PERSON_ROLE(project_id, name, role) VALUES (?,?,?)", (pid, name, "AUTHOR"))
    for p in meta.get("contributors") or []:
        if not isinstance(p, dict):
            continue
        name = p.get("name")
        if name:
            conn.execute(
                "INSERT OR IGNORE INTO PERSON_ROLE(project_id, name, role) VALUES (?,?,?)",
                (pid, name, _map_role(p.get("type"))),
            )


def _insert_license(conn: sqlite3.Connection, pid: int, meta: dict) -> None:
    lic = meta.get("license")
    if not lic:
        return
    value = lic.get("id") if isinstance(lic, dict) else str(lic)
    if value:
        conn.execute("INSERT OR IGNORE INTO LICENSES(project_id, license) VALUES (?,?)", (pid, value))


def _download_file(session: requests.Session, url: str, path: Path, timeout: int) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with session.get(url, stream=True, timeout=timeout) as r:
        r.raise_for_status()
        with path.open("wb") as f:
            for chunk in r.iter_content(chunk_size=256 * 1024):
                if chunk:
                    f.write(chunk)


def _process_record(
    record: dict,
    query: str,
    config: Config,
    session: requests.Session,
    conn: sqlite3.Connection,
    lock: threading.Lock,
) -> tuple[int, int]:
    meta = record.get("metadata", {})
    rec_id = str(record["id"])
    restricted = meta.get("access_right") in ("restricted", "embargoed")
    files = record.get("files") or []
    record_dir = config.download_root / "zenodo" / rec_id
    downloaded = failed = 0

    with lock:
        pid = _upsert_project(conn, query, record, config.download_root)
        _insert_keywords(conn, pid, meta)
        _insert_people(conn, pid, meta)
        _insert_license(conn, pid, meta)

    for f in files:
        name = f.get("key") or f.get("filename") or "unknown"

        if config.no_download:
            continue

        if restricted:
            with lock:
                conn.execute("INSERT OR IGNORE INTO FILES(project_id,file_name,file_type,status) VALUES(?,?,?,?)", (pid, name, _ext(name), "FAILED_LOGIN_REQUIRED"))
            failed += 1
            continue

        size = f.get("size") or 0
        if size > MAX_DOWNLOAD_SIZE:
            with lock:
                conn.execute("INSERT OR IGNORE INTO FILES(project_id,file_name,file_type,status) VALUES(?,?,?,?)", (pid, name, _ext(name), "FAILED_TOO_LARGE"))
            tqdm.write(f"  [{rec_id}] SKIPPED {name} ({size / 1_000_000:.1f} MB > 10 MB limit)")
            failed += 1
            continue

        url = (f.get("links") or {}).get("self") or (f.get("links") or {}).get("content")
        if not url:
            with lock:
                conn.execute("INSERT OR IGNORE INTO FILES(project_id,file_name,file_type,status) VALUES(?,?,?,?)", (pid, name, _ext(name), "FAILED_SERVER_UNRESPONSIVE"))
            failed += 1
            continue

        size_mb = (f.get("size") or 0) / 1_000_000
        tqdm.write(f"  [{rec_id}] {name} ({size_mb:.1f} MB)")
        try:
            _download_file(session, url, record_dir / name, config.timeout)
            status = "SUCCEEDED"
            downloaded += 1
        except requests.HTTPError as e:
            status = "FAILED_LOGIN_REQUIRED" if e.response is not None and e.response.status_code == 403 else "FAILED_SERVER_UNRESPONSIVE"
            tqdm.write(f"  [{rec_id}] FAILED {name}: {e}")
            failed += 1
        except Exception as e:
            status = "FAILED_SERVER_UNRESPONSIVE"
            tqdm.write(f"  [{rec_id}] FAILED {name}: {e}")
            failed += 1

        with lock:
            conn.execute("INSERT OR REPLACE INTO FILES(project_id,file_name,file_type,status) VALUES(?,?,?,?)", (pid, name, _ext(name), status))

    with lock:
        conn.commit()

    return downloaded, failed


def _search_pages(session: requests.Session, query: str, config: Config):
    """Yields (record, total_hits) — total_hits only on first record, then None."""
    page = 1
    first = True
    while True:
        try:
            r = session.get(
                f"{API_BASE}/records",
                params={"q": query, "page": page, "size": config.page_size},
                timeout=config.timeout,
            )
            r.raise_for_status()
            data = r.json()
            hits = data.get("hits", {}).get("hits", [])
            total = data.get("hits", {}).get("total") if first else None
            if isinstance(total, dict):
                total = total.get("value")
        except Exception:
            return
        if not hits:
            return
        for hit in hits:
            yield hit, (total if first else None)
            first = False
        page += 1
        if config.delay > 0:
            time.sleep(config.delay)


def crawl(config: Config) -> dict:
    config.download_root.mkdir(parents=True, exist_ok=True)
    config.db_path.parent.mkdir(parents=True, exist_ok=True)

    counts = {"records": 0, "downloaded": 0, "failed": 0}
    seen: set[str] = set()

    with sqlite3.connect(str(config.db_path), timeout=60, check_same_thread=False) as conn:
        conn.execute("PRAGMA journal_mode=WAL;")
        _create_tables(conn)
        lock = threading.Lock()

        with requests.Session() as session:
            session.headers.update({"User-Agent": "qdarchive/1.0", "Accept": "application/json"})

            for query in config.queries:
                tqdm.write(f"\n[zenodo] query: {query}")
                futures = []
                bar = tqdm(desc=f"  records", unit="rec", dynamic_ncols=True)

                with ThreadPoolExecutor(max_workers=config.workers) as pool:
                    for record, total in _search_pages(session, query, config):
                        if total is not None:
                            bar.total = min(total, config.limit) if config.limit else total
                            bar.refresh()
                        rid = str(record.get("id", ""))
                        if not rid or rid in seen:
                            continue
                        seen.add(rid)
                        counts["records"] += 1
                        futures.append(
                            pool.submit(_process_record, record, query, config, session, conn, lock)
                        )
                        if config.limit and counts["records"] >= config.limit:
                            break

                    for fut in as_completed(futures):
                        try:
                            d, f = fut.result()
                            counts["downloaded"] += d
                            counts["failed"] += f
                        except Exception:
                            counts["failed"] += 1
                        bar.update(1)
                        bar.set_postfix(downloaded=counts["downloaded"], failed=counts["failed"])

                bar.close()
                if config.limit and counts["records"] >= config.limit:
                    break

    tqdm.write(f"\n[zenodo] done | records={counts['records']} downloaded={counts['downloaded']} failed={counts['failed']}")
    return counts


def load_queries_csv(path: Path) -> list[str]:
    queries = []
    with path.open() as f:
        for line in f:
            q = line.strip().strip('"').strip("'")
            if q and not q.lower() == "query":
                queries.append(q)
    return queries
