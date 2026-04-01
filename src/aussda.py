from __future__ import annotations

import sqlite3
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path

import requests
from tqdm import tqdm


API_BASE = "https://data.aussda.at/api"
REPOSITORY_ID = 12
REPOSITORY_URL = "https://data.aussda.at"
TOO_LARGE_BYTES = 5_000_000_000


@dataclass(frozen=True)
class Config:
    queries: list[str]
    limit: int | None
    workers: int
    db_path: Path
    download_root: Path
    no_download: bool
    page_size: int = 500
    timeout: int = 30
    delay: float = 0.2


def _ext(name: str) -> str:
    return name.rsplit(".", 1)[-1].lower() if "." in name else ""


def _doi_url(global_id: str) -> str:
    return global_id.replace("doi:", "https://doi.org/", 1)


def _doi_folder(global_id: str) -> str:
    return global_id.replace("doi:", "").replace("/", "_")


def _get_field(fields: list, type_name: str):
    for f in fields:
        if f.get("typeName") == type_name:
            return f.get("value")
    return None


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


def _upsert_project(conn: sqlite3.Connection, query: str, item: dict, latest: dict) -> int:
    fields = latest["metadataBlocks"]["citation"]["fields"]
    title = _get_field(fields, "title") or ""

    desc_blocks = _get_field(fields, "dsDescription") or []
    description = " ".join(
        d["dsDescriptionValue"]["value"]
        for d in desc_blocks
        if isinstance(d, dict) and isinstance(d.get("dsDescriptionValue"), dict)
    )

    lang_raw = _get_field(fields, "language") or []
    language = lang_raw[0] if lang_raw else None

    doi_url = _doi_url(item["global_id"])
    folder = _doi_folder(item["global_id"])
    version = f'{latest.get("versionNumber", 1)}.{latest.get("versionMinorNumber", 0)}'
    project_url = item.get("url") or doi_url

    conn.execute("""
        INSERT OR IGNORE INTO PROJECTS (
            query_string, repository_id, repository_url, project_url, version,
            title, description, language, doi, upload_date, download_date,
            download_repository_folder, download_project_folder, download_version_folder, download_method
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
    """, (
        query, REPOSITORY_ID, REPOSITORY_URL, project_url,
        version, title, description, language, doi_url,
        latest.get("publicationDate"),
        datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "aussda", folder, version, "API-CALL",
    ))
    return conn.execute("SELECT id FROM PROJECTS WHERE project_url=?", (project_url,)).fetchone()[0]


def _insert_keywords(conn: sqlite3.Connection, pid: int, fields: list) -> None:
    for kw in _get_field(fields, "keyword") or []:
        if isinstance(kw, dict):
            value = (kw.get("keywordValue") or {}).get("value")
            if value:
                conn.execute("INSERT OR IGNORE INTO KEYWORDS(project_id, keyword) VALUES (?,?)", (pid, value))


def _insert_people(conn: sqlite3.Connection, pid: int, fields: list) -> None:
    for a in _get_field(fields, "author") or []:
        if isinstance(a, dict):
            name = (a.get("authorName") or {}).get("value")
            if name:
                conn.execute("INSERT OR IGNORE INTO PERSON_ROLE(project_id, name, role) VALUES (?,?,?)", (pid, name, "AUTHOR"))
    for c in _get_field(fields, "contributor") or []:
        if isinstance(c, dict):
            name = (c.get("contributorName") or {}).get("value")
            if name:
                conn.execute("INSERT OR IGNORE INTO PERSON_ROLE(project_id, name, role) VALUES (?,?,?)", (pid, name, "OTHER"))


def _insert_license(conn: sqlite3.Connection, pid: int, latest: dict) -> None:
    lic = latest.get("license")
    if not lic:
        return
    value = lic.get("name") if isinstance(lic, dict) else str(lic)
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


def _process_dataset(
    item: dict,
    query: str,
    config: Config,
    session: requests.Session,
    conn: sqlite3.Connection,
    lock: threading.Lock,
) -> tuple[int, int]:
    doi = item["global_id"]
    folder = _doi_folder(doi)
    record_dir = config.download_root / "aussda" / folder
    downloaded = failed = 0

    try:
        r = session.get(
            f"{API_BASE}/datasets/:persistentId/",
            params={"persistentId": doi},
            timeout=config.timeout,
        )
        r.raise_for_status()
        latest = r.json()["data"]["latestVersion"]
    except Exception as e:
        tqdm.write(f"  [{folder}] metadata fetch failed: {e}")
        return 0, 1

    fields = latest["metadataBlocks"]["citation"]["fields"]

    with lock:
        pid = _upsert_project(conn, query, item, latest)
        _insert_keywords(conn, pid, fields)
        _insert_people(conn, pid, fields)
        _insert_license(conn, pid, latest)

    for f in latest.get("files") or []:
        df = f.get("dataFile") or {}
        name = df.get("filename") or "unknown"
        file_id = df.get("id")

        if config.no_download or not file_id:
            continue

        size = df.get("filesize") or 0
        if size > TOO_LARGE_BYTES:
            with lock:
                conn.execute("INSERT OR IGNORE INTO FILES(project_id,file_name,file_type,status) VALUES(?,?,?,?)", (pid, name, _ext(name), "FAILED_TOO_LARGE"))
            failed += 1
            continue

        url = f"{API_BASE}/access/datafile/{file_id}"
        tqdm.write(f"  [{folder}] {name} ({size / 1_000_000:.1f} MB)")

        try:
            _download_file(session, url, record_dir / name, config.timeout)
            status = "SUCCEEDED"
            downloaded += 1
        except requests.HTTPError as e:
            status = "FAILED_LOGIN_REQUIRED" if e.response is not None and e.response.status_code in (401, 403) else "FAILED_SERVER_UNRESPONSIVE"
            tqdm.write(f"  [{folder}] FAILED {name}: {e}")
            failed += 1
        except Exception as e:
            status = "FAILED_SERVER_UNRESPONSIVE"
            tqdm.write(f"  [{folder}] FAILED {name}: {e}")
            failed += 1

        with lock:
            conn.execute("INSERT OR REPLACE INTO FILES(project_id,file_name,file_type,status) VALUES(?,?,?,?)", (pid, name, _ext(name), status))

    with lock:
        conn.commit()

    return downloaded, failed


def _search_pages(session: requests.Session, query: str, config: Config):
    start = 0
    first = True
    while True:
        try:
            r = session.get(
                f"{API_BASE}/search",
                params={"q": query, "type": "dataset", "per_page": config.page_size, "start": start},
                timeout=config.timeout,
            )
            r.raise_for_status()
            data = r.json()["data"]
            items = data["items"]
            total = data.get("total_count") if first else None
        except Exception:
            return
        if not items:
            return
        for item in items:
            yield item, (total if first else None)
            first = False
        if len(items) < config.page_size:
            return
        start += config.page_size
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
                tqdm.write(f"\n[aussda] query: {query}")
                futures = []
                bar = tqdm(desc="  datasets", unit="ds", dynamic_ncols=True)

                with ThreadPoolExecutor(max_workers=config.workers) as pool:
                    for item, total in _search_pages(session, query, config):
                        if total is not None:
                            bar.total = min(total, config.limit) if config.limit else total
                            bar.refresh()
                        did = item.get("global_id", "")
                        if not did or did in seen:
                            continue
                        seen.add(did)
                        counts["records"] += 1
                        futures.append(
                            pool.submit(_process_dataset, item, query, config, session, conn, lock)
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

    tqdm.write(f"\n[aussda] done | records={counts['records']} downloaded={counts['downloaded']} failed={counts['failed']}")
    return counts


def load_queries_csv(path: Path) -> list[str]:
    queries = []
    with path.open() as f:
        for line in f:
            q = line.strip().strip('"').strip("'")
            if q and q.lower() != "query":
                queries.append(q)
    return queries
