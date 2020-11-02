# Access to the data used for CONSULT benchmarking

This repository contains summary data tables and scripts we used to processes them.


* Controlled distances.
  - [Tol_all_kmers_bin_comp_lsh_kraken_clark_clarkS_0914.xlsx](https://github.com/noraracht/lsh_scripts/blob/main/Tol_all_kmers_bin_comp_lsh_kraken_clark_clarkS_0914.xlsx) contains recall and false positive information computed per bin for all CONSULT, Kraken-II, CLARK, CLARK-S and Bowtie. It is an input for [Tol_allkmers_bin_cmp_082620.R script](https://github.com/noraracht/lsh_scripts/blob/main/Tol_allkmers_bin_cmp_082620.R) to generate curves depicted in Fig. 2a. 
   - [tools_runtime_1030_in_paper.xlsx](https://github.com/noraracht/lsh_scripts/blob/main/tools_runtime_1030_in_paper.xlsx) includes running time and memory data for CONSULT, Kraken-II, CLARK, CLARK-S and Bowtie used for performance comparison of the tools. The table serves as an input into [tools_runtime_1014.R](https://github.com/noraracht/lsh_scripts/blob/main/tools_runtime_1014.R) to generate bar plots shown in Fig. 2b. 
    
* Novel genomes.
     - [combined_gorg_v1_results.csv](https://github.com/noraracht/lsh_scripts/blob/main/combined_gorg_v1_results.csv) contains percentages of matched reads for every GORG sample searched with default parameters against GTDB, TOL and Bac/Arch Kraken databases for Kraken and CONSULT tools. It is an input for [gorg.R](https://github.com/noraracht/lsh_scripts/blob/main/gorg.R) to generate ECDF curves on Fig. 3a.
     
   - [roc_p3c0.csv](https://github.com/noraracht/lsh_scripts/blob/main/roc_p3c0.csv), [roc_p3c1.csv](https://github.com/noraracht/lsh_scripts/blob/main/roc_p3c1.csv), [roc_p4c0.csv](https://github.com/noraracht/lsh_scripts/blob/main/roc_p4c0.csv) and [roc_p4c1.csv](https://github.com/noraracht/lsh_scripts/blob/main/roc_p4c1.csv) hold mean recall and false positive values for GORG dataset queried against  GTDB, TOL, Bac/Arch Kraken databases at variable settings. These files serves as an input into [combo_ROC.R](https://github.com/noraracht/lsh_scripts/blob/main/combo_ROC.R) to generate ROC curves demonstrated in Fig. 3b. 
    
    
    
  

 


### Real skims


### Theoretical model





