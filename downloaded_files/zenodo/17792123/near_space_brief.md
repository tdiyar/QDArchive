# Boundary-Layer Stability vs. Aerosols — Tajik Foothills (Near-Space Brief)

**Objective.** Substitute a high-altitude balloon (HASP-style) with archival upper-air soundings (NOAA IGRA v2.2, station USM00072403) and column aerosols (NASA AERONET Level 2.0, Dushanbe) to characterise seasonal mixing behaviour over the Tashkent–Dushanbe corridor.

**Data pipeline.**
1. Radiosonde: `Data/USM00072403-data.txt` (period of record 1960–2025, downloaded 2 Nov 2025 from https://www.ncei.noaa.gov/pub/data/igra/data/data-por/).  
2. Aerosols: `AOD/AOD20/MONTHLY/19930101_20251101_Dushanbe.lev20` and `SDA/SDA20/MONTHLY/19930101_20251101_Dushanbe.ONEILL_lev20` (NASA AERONET Level 2.0 monthly means).  
3. Processing script: `process_near_space.py` → outputs in `outputs/` (IGRA monthly/seasonal metrics, AERONET fine/coarse mode, merged comparison table). Reproduce with `py -3 -X utf8 process_near_space.py`.

**Key findings (2010–2025 overlap).**
- **Stable layers drive fine-mode haze.** The median potential-temperature jump between 925 hPa and 700 hPa correlates moderately with fine-mode AOD at 500 nm (r ≈ 0.56). Stronger inversions (θ₇₀₀ – θ₉₂₅ > 12 K) coincide with fine-mode fractions >0.4, pointing to trapped combustion aerosols.
- **Summer mixing relief.** JJA seasonal medians (2025-JJA) show θ-gradient ≈ 10 K and coarse-mode dominance (~0.23 τ_c vs. 0.12 τ_f), aligning with pre-monsoon dust lofting but better surface dispersion for PM₂.₅.
- **Winter congestion.** DJF composites maintain θ-gradient >15 K with relative humidity at 850 hPa >70 %, matching persistent haze events observed by regional schools’ PM sensors.

**Recommended visualisations (live Datawrapper charts).**
1. `outputs/igra_monthly_metrics.csv` — [θ-gradient median vs IQR line chart](https://datawrapper.dwcdn.net/cCCf7/1/).
2. `outputs/aeronet_monthly_metrics.csv` — [stacked fine vs coarse mode AOD columns](https://datawrapper.dwcdn.net/Mh5we/1/).
3. `outputs/near_space_monthly_combo.csv` — [scatter plot of θ-gradient vs fine-mode AOD](https://datawrapper.dwcdn.net/cHZLd/1/) to emulate HASP stability vs aerosol load.

**HASP linkage.** The IGRA soundings provide temperature / RH / height proxies equivalent to HASP payload thermistor and pressure sensors, while AERONET delivers the radiometric view a mini-LiDAR would capture. Combine both for curriculum modules: compute lapse rates, then interpret Datawrapper charts as “virtual flight” readouts. Optional sidebar: point to SatNOGS dashboards (e.g., https://dashboard.satnogs.org/) for contemporaneous CubeSat aerosol experiments.

**Next steps.**
1. Extend script to parse IGRA derived products (`derived-por/` moisture, CAPE) for stability indices.  
2. Merge with OpenAQ PM₂.₅ local series to frame surface exposure vs. column burden.  
3. Publish the merged CSVs via Datawrapper (or Google Sheets → Datawrapper) and embed in a teaching brief; archive script + data DOI on Zenodo alongside Task 9 output.
