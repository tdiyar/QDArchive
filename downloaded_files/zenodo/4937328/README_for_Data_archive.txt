This data package accompanies the paper:
Muthukrishnan, R., Hansel-Welch, N., and Larkin, D (2018), Environmental filtering and competitive exclusion drive biodiversity-invasibility relationships in shallow lake plant communities. Journal of Ecology. 

Included are several data files (in .csv format for tabular data) and the R code for all analyses (a series of .R scripts). All files should be in a single folder and then the "Div_Inv_archive_master.R" script can be run which will in turn source other scripts that load data files, set up data structures and run analyses. The results of each analysis will then be called by the master script. The data sets are large and analyses can take some time so expect some scripts, in particular the "Div_Inv_archive_data_setup.R" script to take an extended amount of time (potentially over 1 hour depending on processor speed) to run. Most analyses will run using only the standard R packages. The only non-standard packages that will need to be installed are the lme4 package (Bates et al. 2015) and the pbkrtest package (Halekoh & Højsgaard 2014).

Data files:
Lake_plant_diversity_data.csv
This is the main data file for plant survey results from DNR surveys

MpcaFqa.csv
tnrs_invasives.csv
tnrs_results.csv
These files provide plant lists that are used to determine native and invasive species. The TNRS files are outputs from the Taxonomic Name Resolution Service that are used to provide more standard names.

Lake_mean_env_data.csv
This file provides the mean values for each lake for the 6 environmental parameters used in the environmental filtering multiple regression analyses.

Analysis files:
Div_Inv_archive_master.R
Main analysis file that will run all other scripts and provide results for each statistical analysis

Div_Inv_archive_data_setup.R
File to load and organize plant survey data for both lake and sampling point scales

Div_Inv_archive_biotic_resistance_analysis.R
File to run biotic resistance analysis

Div_Inv_archive_competitive_exclusion_analysis.R
File to run competitive exclusion analysis

Div_Inv_archive_env_filtering_analysis.R
File to run environmental filtering analysis

Div_Inv_archive_env_heterogeneity_analysis.R
File to run environmental heterogeneity analysis

