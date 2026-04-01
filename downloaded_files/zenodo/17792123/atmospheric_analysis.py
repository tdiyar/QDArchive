"""
Near-Space Atmospheric Analysis - Advanced Scientific Report
Comprehensive atmospheric stability and aerosol loading analysis
"""

import pandas as pd
import numpy as np
from pathlib import Path
from datetime import datetime
from scipy import stats as scipy_stats

BASE_DIR = Path(__file__).resolve().parent
OUTPUT_DIR = BASE_DIR / "outputs"
COMBO_FILE = OUTPUT_DIR / "near_space_monthly_combo.csv"
IGRA_MONTHLY = OUTPUT_DIR / "igra_monthly_metrics.csv"
IGRA_SEASONAL = OUTPUT_DIR / "igra_seasonal_metrics.csv"
AERONET_MONTHLY = OUTPUT_DIR / "aeronet_monthly_metrics.csv"


def load_analysis_data():
    """Load all processed datasets"""
    combo = pd.read_csv(COMBO_FILE)
    combo["month"] = pd.to_datetime(combo["month"])
    
    igra_monthly = pd.read_csv(IGRA_MONTHLY)
    igra_monthly["month"] = pd.to_datetime(igra_monthly["month"])
    
    igra_seasonal = pd.read_csv(IGRA_SEASONAL)
    
    aeronet_monthly = pd.read_csv(AERONET_MONTHLY)
    aeronet_monthly["month"] = pd.to_datetime(aeronet_monthly["month"])
    
    return combo, igra_monthly, igra_seasonal, aeronet_monthly


def calculate_correlations(combo: pd.DataFrame) -> dict:
    """Calculate correlation between stability and aerosol metrics"""
    
    # Clean data for correlation
    clean_combo = combo[["theta_gradient_med", 
                         "Fine_Mode_AOD_500nm[tau_f]",
                         "Coarse_Mode_AOD_500nm[tau_c]",
                         "Total_AOD_500nm[tau_a]",
                         "FineModeFraction_500nm[eta]",
                         "rh_850_med"]].dropna()
    
    correlations = {}
    
    # Stability vs Fine Mode AOD
    if len(clean_combo) > 2:
        r_fine, p_fine = scipy_stats.pearsonr(
            clean_combo["theta_gradient_med"],
            clean_combo["Fine_Mode_AOD_500nm[tau_f]"]
        )
        correlations["stability_vs_fine_aod"] = {
            "r": round(r_fine, 3),
            "p_value": round(p_fine, 4),
            "significance": "significant" if p_fine < 0.05 else "not significant"
        }
        
        # Stability vs Coarse Mode AOD
        r_coarse, p_coarse = scipy_stats.pearsonr(
            clean_combo["theta_gradient_med"],
            clean_combo["Coarse_Mode_AOD_500nm[tau_c]"]
        )
        correlations["stability_vs_coarse_aod"] = {
            "r": round(r_coarse, 3),
            "p_value": round(p_coarse, 4),
            "significance": "significant" if p_coarse < 0.05 else "not significant"
        }
        
        # Stability vs Fine Mode Fraction
        r_fraction, p_fraction = scipy_stats.pearsonr(
            clean_combo["theta_gradient_med"],
            clean_combo["FineModeFraction_500nm[eta]"]
        )
        correlations["stability_vs_fine_fraction"] = {
            "r": round(r_fraction, 3),
            "p_value": round(p_fraction, 4),
            "significance": "significant" if p_fraction < 0.05 else "not significant"
        }
        
        # RH vs Fine Mode AOD
        r_rh, p_rh = scipy_stats.pearsonr(
            clean_combo["rh_850_med"],
            clean_combo["Fine_Mode_AOD_500nm[tau_f]"]
        )
        correlations["humidity_vs_fine_aod"] = {
            "r": round(r_rh, 3),
            "p_value": round(p_rh, 4),
            "significance": "significant" if p_rh < 0.05 else "not significant"
        }
    
    return correlations


def seasonal_comparative_analysis(combo: pd.DataFrame) -> pd.DataFrame:
    """Detailed seasonal comparison"""
    
    combo = combo.copy()
    combo["season"] = combo["month"].dt.month.map({
        12: "DJF", 1: "DJF", 2: "DJF",
        3: "MAM", 4: "MAM", 5: "MAM",
        6: "JJA", 7: "JJA", 8: "JJA",
        9: "SON", 10: "SON", 11: "SON"
    })
    
    seasonal = combo.groupby("season").agg({
        "theta_gradient_med": ["mean", "std", "min", "max"],
        "Fine_Mode_AOD_500nm[tau_f]": ["mean", "std", "min", "max"],
        "Coarse_Mode_AOD_500nm[tau_c]": ["mean", "std", "min", "max"],
        "rh_850_med": ["mean", "std"],
        "soundings": "sum"
    }).round(3)
    
    seasonal.columns = ["_".join(col).strip() for col in seasonal.columns]
    seasonal = seasonal.reset_index()
    
    return seasonal


def identify_high_pollution_episodes(combo: pd.DataFrame) -> pd.DataFrame:
    """Identify months with high aerosol loading and strong inversions"""
    
    # Define thresholds
    STRONG_INVERSION_THRESHOLD = 12  # K
    HIGH_FINE_AOD_THRESHOLD = 0.3
    HIGH_RH_THRESHOLD = 70  # %
    
    combo = combo.copy()
    combo["high_pollution_episode"] = (
        (combo["theta_gradient_med"] > STRONG_INVERSION_THRESHOLD) &
        (combo["Fine_Mode_AOD_500nm[tau_f]"] > HIGH_FINE_AOD_THRESHOLD)
    )
    
    combo["stagnant_conditions"] = (
        (combo["theta_gradient_med"] > STRONG_INVERSION_THRESHOLD) &
        (combo["rh_850_med"] > HIGH_RH_THRESHOLD)
    )
    
    episodes = combo[combo["high_pollution_episode"]].copy()
    episodes["year"] = episodes["month"].dt.year
    episodes["month_name"] = episodes["month"].dt.strftime("%Y-%b")
    
    return episodes[[
        "month_name", 
        "theta_gradient_med", 
        "Fine_Mode_AOD_500nm[tau_f]",
        "Coarse_Mode_AOD_500nm[tau_c]",
        "rh_850_med",
        "stagnant_conditions"
    ]]


def calculate_mixing_metrics(combo: pd.DataFrame) -> pd.DataFrame:
    """Calculate boundary layer mixing indicators"""
    
    combo = combo.copy()
    
    # Mixing potential (inverse of stability)
    combo["mixing_potential"] = 1 / (combo["theta_gradient_med"] + 1)
    
    # Ventilation index proxy (stability + moisture)
    combo["ventilation_index"] = combo["mixing_potential"] * (100 - combo["rh_850_med"])
    
    # Classify conditions
    def classify_dispersion(row):
        if row["theta_gradient_med"] < 8:
            return "Excellent"
        elif row["theta_gradient_med"] < 12:
            return "Good"
        elif row["theta_gradient_med"] < 15:
            return "Moderate"
        else:
            return "Poor"
    
    combo["dispersion_potential"] = combo.apply(classify_dispersion, axis=1)
    
    return combo[[
        "month",
        "theta_gradient_med",
        "rh_850_med",
        "mixing_potential",
        "ventilation_index",
        "dispersion_potential"
    ]]


def aerosol_source_attribution(combo: pd.DataFrame) -> pd.DataFrame:
    """Estimate aerosol source types based on fine/coarse ratio"""
    
    combo = combo.copy()
    
    # Fine mode fraction as indicator
    def attribute_source(row):
        fine_frac = row["FineModeFraction_500nm[eta]"]
        
        if pd.isna(fine_frac):
            return "Unknown"
        elif fine_frac > 0.6:
            return "Combustion-dominated (urban/biomass)"
        elif fine_frac > 0.4:
            return "Mixed (combustion + dust)"
        else:
            return "Dust-dominated (natural)"
    
    combo["likely_source"] = combo.apply(attribute_source, axis=1)
    
    # Count by season
    combo["season"] = combo["month"].dt.month.map({
        12: "DJF", 1: "DJF", 2: "DJF",
        3: "MAM", 4: "MAM", 5: "MAM",
        6: "JJA", 7: "JJA", 8: "JJA",
        9: "SON", 10: "SON", 11: "SON"
    })
    
    source_summary = pd.crosstab(combo["season"], combo["likely_source"])
    
    return source_summary


def generate_atmospheric_insights(combo: pd.DataFrame, 
                                  correlations: dict) -> list:
    """Generate scientific insights from the analysis"""
    
    insights = []
    
    # Correlation insights
    if "stability_vs_fine_aod" in correlations:
        corr = correlations["stability_vs_fine_aod"]
        if corr["significance"] == "significant":
            insights.append({
                "category": "Atmospheric Dynamics",
                "insight": f"Strong stability correlates with fine-mode aerosols (r={corr['r']})",
                "implication": "Inversions trap combustion emissions near surface",
                "evidence": f"p-value = {corr['p_value']}"
            })
    
    # Seasonal patterns
    winter = combo[combo["month"].dt.month.isin([12, 1, 2])]
    summer = combo[combo["month"].dt.month.isin([6, 7, 8])]
    
    if not winter.empty and not summer.empty:
        winter_stability = winter["theta_gradient_med"].mean()
        summer_stability = summer["theta_gradient_med"].mean()
        
        if winter_stability > summer_stability * 1.3:
            insights.append({
                "category": "Seasonal Variation",
                "insight": "Winter shows significantly stronger inversions",
                "implication": "Heating season exacerbates air quality issues",
                "evidence": f"Winter: {winter_stability:.1f}K vs Summer: {summer_stability:.1f}K"
            })
    
    # High pollution episodes
    high_episodes = combo[
        (combo["theta_gradient_med"] > 12) &
        (combo["Fine_Mode_AOD_500nm[tau_f]"] > 0.3)
    ]
    
    if len(high_episodes) > 0:
        insights.append({
            "category": "Air Quality Events",
            "insight": f"{len(high_episodes)} months with combined high stability + aerosols",
            "implication": "Critical periods for health interventions",
            "evidence": "θ-gradient >12K and fine-mode AOD >0.3"
        })
    
    # Humidity factor
    high_rh = combo[combo["rh_850_med"] > 70]
    if not high_rh.empty:
        avg_fine_aod = high_rh["Fine_Mode_AOD_500nm[tau_f]"].mean()
        insights.append({
            "category": "Moisture Effects",
            "insight": f"High humidity months show elevated fine aerosols (mean AOD: {avg_fine_aod:.3f})",
            "implication": "Hygroscopic growth enhances particle concentrations",
            "evidence": f"{len(high_rh)} months with RH >70%"
        })
    
    return insights


def generate_comprehensive_atmospheric_report():
    """Generate full atmospheric science analysis report"""
    
    print("=" * 80)
    print("NEAR-SPACE ATMOSPHERIC ANALYSIS")
    print("Boundary Layer Stability and Aerosol Loading Assessment")
    print(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 80)
    print()
    
    # Load data
    print("Loading atmospheric datasets...")
    combo, igra_monthly, igra_seasonal, aeronet_monthly = load_analysis_data()
    print(f"Analysis period: {combo['month'].min().date()} to {combo['month'].max().date()}")
    print(f"Total months analyzed: {len(combo)}")
    print()
    
    # Correlation Analysis
    print("-" * 80)
    print("CORRELATION ANALYSIS: Stability vs Aerosols")
    print("-" * 80)
    correlations = calculate_correlations(combo)
    for key, corr in correlations.items():
        metric_name = key.replace("_", " ").title()
        print(f"\n{metric_name}:")
        print(f"  Correlation (r): {corr['r']}")
        print(f"  P-value: {corr['p_value']}")
        print(f"  Statistical significance: {corr['significance']}")
    
    corr_df = pd.DataFrame([{
        "metric": k,
        "correlation": v["r"],
        "p_value": v["p_value"],
        "significant": v["significance"]
    } for k, v in correlations.items()])
    corr_df.to_csv(OUTPUT_DIR / "correlation_analysis.csv", index=False)
    print()
    
    # Seasonal Analysis
    print("-" * 80)
    print("SEASONAL COMPARATIVE ANALYSIS")
    print("-" * 80)
    seasonal = seasonal_comparative_analysis(combo)
    print(seasonal.to_string(index=False))
    seasonal.to_csv(OUTPUT_DIR / "seasonal_comparative_analysis.csv", index=False)
    print()
    
    # High Pollution Episodes
    print("-" * 80)
    print("HIGH POLLUTION EPISODES")
    print("-" * 80)
    episodes = identify_high_pollution_episodes(combo)
    if not episodes.empty:
        print(f"Identified {len(episodes)} high pollution episodes")
        print("\nRecent episodes:")
        print(episodes.tail(10).to_string(index=False))
        episodes.to_csv(OUTPUT_DIR / "high_pollution_episodes.csv", index=False)
    else:
        print("No high pollution episodes identified")
    print()
    
    # Mixing Metrics
    print("-" * 80)
    print("BOUNDARY LAYER MIXING METRICS")
    print("-" * 80)
    mixing = calculate_mixing_metrics(combo)
    print("\nDispersion Potential Distribution:")
    print(mixing["dispersion_potential"].value_counts())
    mixing.to_csv(OUTPUT_DIR / "mixing_metrics.csv", index=False)
    print()
    
    # Source Attribution
    print("-" * 80)
    print("AEROSOL SOURCE ATTRIBUTION")
    print("-" * 80)
    sources = aerosol_source_attribution(combo)
    print(sources)
    sources.to_csv(OUTPUT_DIR / "aerosol_source_attribution.csv")
    print()
    
    # Scientific Insights
    print("-" * 80)
    print("KEY SCIENTIFIC INSIGHTS")
    print("-" * 80)
    insights = generate_atmospheric_insights(combo, correlations)
    for i, insight in enumerate(insights, 1):
        print(f"\n{i}. [{insight['category']}]")
        print(f"   Finding: {insight['insight']}")
        print(f"   Implication: {insight['implication']}")
        print(f"   Evidence: {insight['evidence']}")
    
    insights_df = pd.DataFrame(insights)
    insights_df.to_csv(OUTPUT_DIR / "scientific_insights.csv", index=False)
    print()
    
    # Summary Statistics
    print("-" * 80)
    print("SUMMARY STATISTICS")
    print("-" * 80)
    print(f"Mean θ-gradient (700-925 hPa): {combo['theta_gradient_med'].mean():.2f} K")
    print(f"Mean fine-mode AOD: {combo['Fine_Mode_AOD_500nm[tau_f]'].mean():.3f}")
    print(f"Mean coarse-mode AOD: {combo['Coarse_Mode_AOD_500nm[tau_c]'].mean():.3f}")
    print(f"Mean RH at 850 hPa: {combo['rh_850_med'].mean():.1f}%")
    print()
    
    print("=" * 80)
    print(f"ANALYSIS COMPLETE - All outputs saved to: {OUTPUT_DIR}")
    print("=" * 80)


if __name__ == "__main__":
    generate_comprehensive_atmospheric_report()
