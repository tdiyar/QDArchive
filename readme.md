# QDArchive Crawler

Crawls **Zenodo** and **AUSSDA** via their REST APIs, downloads all files per matched record, and stores metadata in a shared SQLite database.

## Setup

```bash
conda env create -f env.yaml
conda activate qda_crawl
```

## Run

### Zenodo

Single query:
```bash
python run.py --source zenodo --query qdpx
```

From CSV (one query per row):
```bash
python run.py --source zenodo --csv queries.csv
```

### AUSSDA

No query needed — fetches all 1600+ datasets by default:
```bash
python run.py --source aussda
```

Specific search term:
```bash
python run.py --source aussda --query qualitative
```

From CSV:
```bash
python run.py --source aussda --csv aussda_queries.csv
```

### Common options

Limit records (for testing):
```bash
python run.py --source zenodo --query qdpx --limit 10
python run.py --source aussda --limit 10
```

Metadata only (no downloads):
```bash
python run.py --source zenodo --query qdpx --no-download
python run.py --source aussda --no-download
```

Custom output paths:
```bash
python run.py --source zenodo --query qdpx \
    --download-dir /data/qda \
    --db-path /data/qda/metadata.db
```

## Arguments

| Argument | Default | Description |
| --- | --- | --- |
| `--source` | required | `zenodo` or `aussda` |
| `--query` | — | Single query string (`*` for all, default for aussda) |
| `--csv` | — | CSV file with one query per row (takes priority over `--query`) |
| `--limit` | none | Max records to process |
| `--workers` | 3 | Parallel download workers |
| `--download-dir` | `downloaded_files` | Root output folder |
| `--db-path` | `downloaded_files/metadata.db` | SQLite file path |
| `--no-download` | off | Store metadata only |

## Output

```
downloaded_files/
  metadata.db                              # shared SQLite database
  zenodo/<record_id>/<file_name>           # Zenodo files
  aussda/<doi_folder>/<file_name>          # AUSSDA files (e.g. 10.11587_ZZPCXX/)
```

Both sources write into the same database — differentiated by `repository_id` (Zenodo=1, AUSSDA=12).

## Database tables

- `PROJECTS` — one row per record/dataset
- `FILES` — one row per file; status: `SUCCEEDED / FAILED_SERVER_UNRESPONSIVE / FAILED_LOGIN_REQUIRED / FAILED_TOO_LARGE`
- `KEYWORDS` — per record
- `PERSON_ROLE` — creators/authors → `AUTHOR`; contributors → `OTHER`
- `LICENSES` — raw license identifier

## Query files

| File | Source | Notes |
| --- | --- | --- |
| `queries.csv` | Zenodo | Search terms like `qdpx`, `qda`, `qualitative` |
| `aussda_queries.csv` | AUSSDA | Usually just `*` (fetch everything) |

## Notes

- Restricted files: metadata stored, downloads attempted; HTTP 403 → `FAILED_LOGIN_REQUIRED`
- Files over 5 GB: marked `FAILED_TOO_LARGE`, skipped
- HTML in descriptions stripped; entities decoded (Zenodo)
- Runs are idempotent — re-running skips already-inserted projects
- Both sources share the same DB and can be run simultaneously into different DB paths if needed
- Rate limits: Zenodo guest ~60 req/min; AUSSDA has no documented limit — default delay 0.2s
