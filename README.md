# Access to the data used for CONSULT benchmarking

This repository contains summary data tables and scripts we used to processes them.


* Controlled distances
  - [Tol_all_kmers_bin_comp_lsh_kraken_clark_clarkS_0914.xlsx](https://github.com/noraracht/lsh_scripts/blob/main/Tol_all_kmers_bin_comp_lsh_kraken_clark_clarkS_0914.xlsx) contains recall and false positive information computed per bin for all CONSULT, Kraken-II, CLARK, CLARK-S and Bowtie. It is an input for [Tol_allkmers_bin_cmp_082620.R script](https://github.com/noraracht/lsh_scripts/blob/main/Tol_allkmers_bin_cmp_082620.R) to generate curves depicted in Fig. 2a. 
  
   - [tools_runtime_1030_in_paper.xlsx](https://github.com/noraracht/lsh_scripts/blob/main/tools_runtime_1030_in_paper.xlsx) includes running time and memory data for CONSULT, Kraken-II, CLARK, CLARK-S and Bowtie used for performance comparison of the tools. The table serves as an input into [tools_runtime_1014.R](https://github.com/noraracht/lsh_scripts/blob/main/tools_runtime_1014.R) to generate bar plots shown in Fig. 2b. 
    
    
* Novel genomes
     - [combined_gorg_v1_results.csv](https://github.com/noraracht/lsh_scripts/blob/main/combined_gorg_v1_results.csv) contains percentages of matched reads for every GORG sample searched with default parameters against GTDB, TOL and Bac/Arch Kraken databases for Kraken and CONSULT tools. It is an input for [gorg.R](https://github.com/noraracht/lsh_scripts/blob/main/gorg.R) to generate ECDF curves on Fig. 3a.
     
   - [roc_p3c0.csv](https://github.com/noraracht/lsh_scripts/blob/main/roc_p3c0.csv), [roc_p3c1.csv](https://github.com/noraracht/lsh_scripts/blob/main/roc_p3c1.csv), [roc_p4c0.csv](https://github.com/noraracht/lsh_scripts/blob/main/roc_p4c0.csv) and [roc_p4c1.csv](https://github.com/noraracht/lsh_scripts/blob/main/roc_p4c1.csv) hold mean recall and false positive values for GORG dataset queried against  GTDB, TOL, Bac/Arch Kraken databases at variable settings. These files serves as an input into [combo_ROC.R](https://github.com/noraracht/lsh_scripts/blob/main/combo_ROC.R) to generate ROC curves demonstrated in Fig. 3b. 
   
   - [compare_gorg_kraken_vs_lsh_matched.csv](https://github.com/noraracht/lsh_scripts/blob/main/compare_gorg_kraken_vs_lsh_matched.csv) includes data about percentage difference in number of reads matched for every sample from GORG set queried against GTDB with default parameters. The table is an input into [consult_vs_kraken_matched_dif_hist.R](https://github.com/noraracht/lsh_scripts/blob/main/consult_vs_kraken_matched_dif_hist.R) that computes histogram on Fig. S6.
  
  
* Real skims
   - [script_dros_heatmap_v1.R](https://github.com/noraracht/lsh_scripts/blob/main/script_dros_heatmap_v1.R) takes an as input [dros_distances.csv](https://github.com/noraracht/lsh_scripts/blob/main/dros_distances.csv) that contains distance values and relative error information (ground truth, before and after filtering) for all combinations of Drosophila species and [lsh_gtdb_results_dros_queries.csv](https://github.com/noraracht/lsh_scripts/blob/main/lsh_gtdb_results_dros_queries.csv) that lists percentage of reads that have been filtered out with DTDB. This script generates tile plot on Fig. 4 and histogram on Fig. S5.
 
 
 * Parameter setting
  - [gorgQ_GTDB_var_p_var_c.R](https://github.com/noraracht/lsh_scripts/blob/main/gorgQ_GTDB_var_p_var_c.R) combines data from [combined_gorg_v1_results_var_p.csv](https://github.com/noraracht/lsh_scripts/blob/main/combined_gorg_v1_results_var_p.csv) that includes mean recall and [combined_10M_FP_plants_results_var_p_var_c.csv](https://github.com/noraracht/lsh_scripts/blob/main/combined_10M_FP_plants_results_var_p_var_c.csv) containing false positive values obtained from GORG queries searched against GTDB using CONSULT with variable *p* and *c*. The script generates plot on Fig. S2.
  
  S3 S4
  Table 1


* Theoretical model
   - Scirpt to generate theoretical model in Fig. 1b. and Fig. S1.
   - [Consult_v3.pptx](https://github.com/noraracht/lsh_scripts/blob/main/Consult_v3.pptx) is the sketch of the software archutecture on Fig. 1a.





