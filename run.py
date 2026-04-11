from __future__ import annotations

import argparse
from pathlib import Path


def main() -> None:
    p = argparse.ArgumentParser(description="QDArchive crawler")
    p.add_argument("--source", choices=["zenodo", "aussda"], required=True)
    p.add_argument("--query", help="Single query string")
    p.add_argument("--csv", type=Path, help="CSV with one query per row (takes priority over --query)")
    p.add_argument("--limit", type=int, default=None, help="Max records (for testing)")
    p.add_argument("--workers", type=int, default=3, help="Parallel workers (default: 3)")
    p.add_argument("--download-dir", type=Path, default=Path("downloaded_files"))
    p.add_argument("--db-path", type=Path, default=Path("23711815-seeding.db"))
    p.add_argument("--no-download", action="store_true", help="Metadata only, skip file downloads")
    args = p.parse_args()

    if args.source == "zenodo":
        from src.zenodo import Config, crawl, load_queries_csv
        default_query = None
    else:
        from src.aussda import Config, crawl, load_queries_csv
        default_query = "*"

    if args.csv:
        queries = load_queries_csv(args.csv)
    elif args.query:
        queries = [args.query]
    elif default_query:
        queries = [default_query]
    else:
        p.error("Provide --query or --csv")

    config = Config(
        queries=queries,
        limit=args.limit,
        workers=args.workers,
        db_path=args.db_path,
        download_root=args.download_dir,
        no_download=args.no_download,
    )
    crawl(config)


if __name__ == "__main__":
    main()
