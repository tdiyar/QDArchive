This archive contains the following data files:

 master-input.csv: Full data set, including full genotype information and geographical location of the origin patch for all sampled larvae.
   - ID: the unique identifier of each individual
   - Region: origin region for the individual (Sottunga/Föglö/Saltvik); each region is considered independently from the  others
   - Year: sampling year
   - Patch: identifier of the origin patch
   - Clutch: identifier of the origin clutch; individuals with the same clutch ID have been obtained from the same egg clutch (2/3 individuals in most cases)
   - Patch Centroid_X ,Patch Centroid_Y: approximate geographical location for the patch centre in ETRS-TM35FIN coordinate system; used as a approximate location for origin egg clutch
   - KASPX-XXX: genotypes
 
 master-output.csv: Final full-sib predictions based on COLONY2 results.
   - ID,Region,Year: same as in master-input.csv
   - COLONY2 Family ID: ID of the final inferred family group; individuals with same year, area and Family ID are predicted to be full sibs
 
 colony-input-master/: COLONY2 input files, based on the data in master-input.csv. Contains five duplicate input files for each year and geographical area with different random seeds.
 
 colony-output-master-trimmed/: Result files for COLONY2 runs.