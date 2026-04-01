from __future__ import annotations

from pathlib import Path
from typing import Dict, List, Optional

import math
import pandas as pd

BASE_DIR = Path(__file__).resolve().parent
DATA_DIR = BASE_DIR / "Data"
IGRA_FILE = DATA_DIR / "USM00072403-data.txt"
AOD_FILE = DATA_DIR / "AOD" / "AOD20" / "MONTHLY" / "19930101_20251101_Dushanbe.lev20"
SDA_FILE = (
    DATA_DIR
    / "SDA"
    / "SDA20"
    / "MONTHLY"
    / "19930101_20251101_Dushanbe.ONEILL_lev20"
)
OUTPUT_DIR = BASE_DIR / "outputs"


def _parse_int(segment: str) -> Optional[int]:
    segment = segment.strip()
    if not segment or segment in {"-9999", "-8888"}:
        return None
    return int(segment)


def _parse_float(segment: str, scale: float) -> Optional[float]:
    value = _parse_int(segment)
    if value is None:
        return None
    return value / scale


def _potential_temperature(temp_c: float, pressure_hpa: float) -> float:
    """Compute potential temperature (K) using Poisson's equation."""
    temp_k = temp_c + 273.15
    exponent = 0.2854  # R/cp for dry air
    return temp_k * (1000.0 / pressure_hpa) ** exponent


def parse_igra_soundings(path: Path) -> pd.DataFrame:
    records: List[Dict[str, float]] = []
    with path.open("r", encoding="utf-8") as handle:
        while True:
            header = handle.readline()
            if not header:
                break
            if not header.startswith("#"):
                continue

            year = _parse_int(header[13:17])
            month = _parse_int(header[18:20])
            day = _parse_int(header[21:23])
            hour = _parse_int(header[24:26])
            num_levels = _parse_int(header[32:36]) or 0

            if not (year and month and day):
                # skip malformed entries
                for _ in range(num_levels):
                    handle.readline()
                continue

            sounding_ts = pd.Timestamp(
                year=int(year),
                month=int(month),
                day=int(day),
                hour=int(hour) if hour is not None and hour <= 23 else 0,
            )

            level_store: Dict[int, Dict[str, Optional[float]]] = {}

            for _ in range(num_levels):
                data_line = handle.readline()
                if not data_line:
                    break
                lvl_type_major = _parse_int(data_line[0:1])
                pressure = _parse_int(data_line[9:15])
                gph = _parse_int(data_line[16:21])
                temp_c = _parse_float(data_line[22:27], 10.0)
                rh = _parse_float(data_line[28:33], 10.0)

                if pressure is None or lvl_type_major is None:
                    continue
                pressure_hpa = pressure / 100.0
                pressure_key = int(round(pressure_hpa))

                level_store[pressure_key] = {
                    "pressure_hpa": pressure_hpa,
                    "gph": float(gph) if gph is not None else math.nan,
                    "temp_c": temp_c if temp_c is not None else math.nan,
                    "rh": rh if rh is not None else math.nan,
                }

            lvl925 = level_store.get(925)
            lvl850 = level_store.get(850)
            lvl700 = level_store.get(700)

            if not lvl925 or not lvl700:
                continue
            if math.isnan(lvl925["temp_c"]) or math.isnan(lvl700["temp_c"]):
                continue

            theta925 = _potential_temperature(
                lvl925["temp_c"], lvl925["pressure_hpa"]
            )
            theta700 = _potential_temperature(
                lvl700["temp_c"], lvl700["pressure_hpa"]
            )
            theta850 = (
                _potential_temperature(lvl850["temp_c"], lvl850["pressure_hpa"])
                if lvl850 and not math.isnan(lvl850["temp_c"])
                else math.nan
            )

            record = {
                "datetime": sounding_ts,
                "theta_gradient_700_925_K": theta700 - theta925,
                "theta_850_K": theta850,
                "relative_humidity_850_pct": lvl850["rh"]
                if lvl850 and not math.isnan(lvl850["rh"])
                else math.nan,
                "height_925_m": lvl925["gph"]
                if lvl925 and not math.isnan(lvl925["gph"])
                else math.nan,
                "height_diff_700_925_m": (
                    lvl700["gph"] - lvl925["gph"]
                    if lvl700
                    and lvl925
                    and not math.isnan(lvl700["gph"])
                    and not math.isnan(lvl925["gph"])
                    else math.nan
                ),
            }
            records.append(record)
    df = pd.DataFrame.from_records(records)
    df = df.dropna(subset=["theta_gradient_700_925_K"])
    return df


def compute_monthly_metrics(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()
    df["month"] = df["datetime"].dt.to_period("M")
    agg = (
        df.groupby("month")
        .agg(
            theta_gradient_med=("theta_gradient_700_925_K", "median"),
            theta_gradient_iqr=("theta_gradient_700_925_K", lambda s: s.quantile(0.75) - s.quantile(0.25)),
            rh_850_med=("relative_humidity_850_pct", "median"),
            height_diff_med=("height_diff_700_925_m", "median"),
            soundings=("theta_gradient_700_925_K", "count"),
        )
        .reset_index()
    )
    agg["month"] = agg["month"].astype(str)
    return agg


def compute_seasonal_metrics(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()

    def season_label(ts: pd.Timestamp) -> str:
        month = ts.month
        if month in (12, 1, 2):
            season = "DJF"
            year = ts.year if month != 12 else ts.year + 1
        elif month in (3, 4, 5):
            season = "MAM"
            year = ts.year
        elif month in (6, 7, 8):
            season = "JJA"
            year = ts.year
        else:
            season = "SON"
            year = ts.year
        return f"{year}-{season}"

    df["season"] = df["datetime"].apply(season_label)
    agg = (
        df.groupby("season")
        .agg(
            theta_gradient_med=("theta_gradient_700_925_K", "median"),
            theta_gradient_iqr=("theta_gradient_700_925_K", lambda s: s.quantile(0.75) - s.quantile(0.25)),
            rh_850_med=("relative_humidity_850_pct", "median"),
            height_diff_med=("height_diff_700_925_m", "median"),
            soundings=("theta_gradient_700_925_K", "count"),
        )
        .reset_index()
    )
    return agg


def read_aeronet_monthly(path: Path) -> pd.DataFrame:
    df = pd.read_csv(
        path,
        skiprows=6,
        na_values=["-999.000000"],
    )
    df = df[df["Month"].astype(str).str.contains("-")]
    df["month"] = pd.to_datetime(df["Month"], format="%Y-%b").dt.to_period("M")
    df = df.rename(columns={"440-870_Angstrom_Exponent": "AE_440_870"})
    keep_cols = [
        "month",
        "AOD_500nm",
        "AOD_870nm",
        "AE_440_870",
        "NUM_DAYS[AOD_500nm]",
    ]
    return df[keep_cols]


def read_sda_monthly(path: Path) -> pd.DataFrame:
    df = pd.read_csv(path, skiprows=6, na_values=["-999.000000"])
    df = df[df["Month"].astype(str).str.contains("-")]
    df["month"] = pd.to_datetime(df["Month"], format="%Y-%b").dt.to_period("M")
    keep_cols = [
        "month",
        "Total_AOD_500nm[tau_a]",
        "Fine_Mode_AOD_500nm[tau_f]",
        "Coarse_Mode_AOD_500nm[tau_c]",
        "FineModeFraction_500nm[eta]",
    ]
    return df[keep_cols]


def main():
    OUTPUT_DIR.mkdir(exist_ok=True)

    igra_df = parse_igra_soundings(IGRA_FILE)
    igra_monthly = compute_monthly_metrics(igra_df)
    igra_seasonal = compute_seasonal_metrics(igra_df)

    igra_monthly.to_csv(OUTPUT_DIR / "igra_monthly_metrics.csv", index=False)
    igra_seasonal.to_csv(OUTPUT_DIR / "igra_seasonal_metrics.csv", index=False)

    aod_monthly = read_aeronet_monthly(AOD_FILE)
    sda_monthly = read_sda_monthly(SDA_FILE)

    aerosol_monthly = (
        aod_monthly.merge(sda_monthly, on="month", how="inner")
        .sort_values("month")
        .rename(columns={"NUM_DAYS[AOD_500nm]": "obs_days"})
    )
    aerosol_monthly["month"] = aerosol_monthly["month"].astype(str)

    aerosol_monthly.to_csv(OUTPUT_DIR / "aeronet_monthly_metrics.csv", index=False)

    merged = (
        igra_monthly.merge(
            aerosol_monthly,
            on="month",
            how="inner",
        )
        .query("month >= '2010-01'")
        .reset_index(drop=True)
    )
    merged.to_csv(OUTPUT_DIR / "near_space_monthly_combo.csv", index=False)


if __name__ == "__main__":
    main()
