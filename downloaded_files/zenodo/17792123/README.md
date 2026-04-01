# Near-Space Science via Open Archives

This directory pairs NOAA IGRA upper-air soundings with NASA AERONET Level 2.0 aerosol records to emulate a high-altitude student payload (“HASP without balloons”).

## Data inventory

- `Data/USM00072403-data.txt` — IGRA v2.2 station USM00072403 (Tashkent region) period-of-record soundings.
- `Data/AOD/...Dushanbe.lev20` — AERONET monthly aerosol optical depth.
- `Data/SDA/...Dushanbe.ONEILL_lev20` — AERONET spectral deconvolution (fine/coarse separation).

## Processing

```powershell
py -3 -X utf8 process_near_space.py
```

Outputs saved under `outputs/`:
- `igra_monthly_metrics.csv`, `igra_seasonal_metrics.csv`.
- `aeronet_monthly_metrics.csv`.
- `near_space_monthly_combo.csv` (merged stability vs. aerosols table).

## Brief & teaching notes

`near_space_brief.md` summarises findings, suggested charts, and classroom applications referencing the HASP concept. Use the CSVs above as direct uploads to Datawrapper (line/area/scatter combos described in the brief).

## Next steps

- Incorporate IGRA derived indices (CAPE, mixing height) for richer boundary-layer diagnostics.
- Join with surface PM (e.g., OpenAQ Tashkent) for full column-to-surface storyline.
- Snapshot this repo + outputs to Zenodo alongside the FOIA republisher deliverable for permanent citation.
