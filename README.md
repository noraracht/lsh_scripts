# Access to the data used for CONSULT benchmarking

This repository contains summary data tables and scripts we used to processes them.


* Filtering on simulated Drosophila genome skims with non overlapping contaminant portions.
    - [Drosophila_contam_both_species_formatted.xls](https://github.com/noraracht/kraken_scripts/blob/master/Drosophila_contam_both_species_formatted.xls) contains information about genomic distances estimated before and after filtering for simulated Drosophila genomes where only one of the species was contaminated. [E4_script_NO_conf.R](https://github.com/noraracht/kraken_scripts/blob/master/E4_script_NO_conf.R) script takes this data table as an input and generates results for experiment represented in Fig. 4a.
     - [Drosophila_contam_both_species_formatted_withAlpha.xls](https://github.com/noraracht/kraken_scripts/blob/master/Drosophila_contam_both_species_formatted_withAlpha.xls) summarizes information about genomic distances estimated before and after filtering for the same experiment as above but reported for *k* = {28, 32, 35} and *α* = {0.00, 0.05}. [E3_script_two_conf.R](https://github.com/noraracht/kraken_scripts/blob/master/E3_script_two_conf.R) script takes this data table as an input and generates results plot in Fig. S8.

* Filtering on simulated Drosophila genome skims with overlapping contaminant portions.
    - [my-data-output_true_H.csv](https://github.com/noraracht/kraken_scripts/blob/master/my-data-output_true_H.csv) includes information about genomic distances estimated before and after filtering for simulated Drosophila skims with overlapping contaminants. Data also include actual percent overlap between contaminant portions computed throught *k*\-mer analysis. [dros-overlap-exp-Tol-db.R](https://github.com/noraracht/kraken_scripts/blob/master/dros-overlap-exp-Tol-db.R) script takes this data table as an input and generates results for experiment shown in Fig. 4b.
