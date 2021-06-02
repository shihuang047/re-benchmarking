# Challenges in benchmarking metagenomics profilers

This repo contains the code to reproduce all of the analyses in the paper "Challenges in benchmarking metagenomic profilers" by Zheng, Huang et al. 2020.

* The paper has been available at: https://www.nature.com/articles/s41592-021-01141-3
* The raw data is available on figshare: https://figshare.com/projects/Pitfalls_and_Opportunities_in_Benchmarking_Metagenomic_Classifiers/79916

***
## The motivations
Microbial identification and accurate abundance estimation are still challenging in the metagenomics analysis yet poorly understood and evaluated using appropriate metrics or ground truth data. 

**Abundance estimation: sequence abundance VS taxonomic abundance** Microbial abundance in the metagenomics data can be considered either as the relative abundance of reads from each taxa ("sequence abundance") or by inferring abundance of the number of individuals from each taxa by correcting read counts for genome size ("taxonomic abundance"). However, such correction for genome length into abundance estimation is usually missed in most state-of-the-art profilers. Even though it can be manually performed by reweighting the read counts after classification, [previous benchmarking studies](https://www.sciencedirect.com/science/article/pii/S0092867419307755) did not perform appropriate corrections and still used "raw" abundance profiles generated from benchmarked profilers for performance comparisons , resulting in highly misleading or even contradictory conclusions.

## System requirements and installation guide
All the scripts are programmed using R (3.6.3) or Python (3.6.10) and stroed in folder "Manuscript".
For more details please refer to "Readme.txt" under each folder.
RStudio in Windows is recommended to perform visualzation of main figures (please see "Manuscript/Figures").

## Reference
* Ye, S.H., Siddle, K.J., Park, D.J., and Sabeti, P.C. (2019). Benchmarking Metagenomics Tools for Taxonomic Classification. Cell 178, 779-794.
* D., Foox, J., Ahsanuddin, S., et al. (2017). Comprehensive benchmarking and ensemble approaches for metagenomic classifiers. Genome Biology 18.
* Segata, N., Waldron, L., Ballarini, A., Narasimhan, V., Jousson, O., and Huttenhower, C. (2012). Metagenomic microbial community profiling using unique clade-specific marker genes. Nat Methods 9, 811-+.
* Mende, D.R., Waller, A.S., Sunagawa, S., Jarvelin, A.I., Chan, M.M., Arumugam, M., Raes, J., and Bork, P. (2012). Assessment of Metagenomic Assembly Using Simulated Next Generation Sequencing Data. Plos One 7.
* Truong, D.T., Franzosa, E.A., Tickle, T.L., Scholz, M., Weingart, G., Pasolli, E., Tett, A., Huttenhower, C., and Segata, N. (2015). MetaPhlAn2 for enhanced metagenomic taxonomic profiling. Nat Methods 12, 902-903.
* Wood, D.E., and Salzberg, S.L. (2014). Kraken: ultrafast metagenomic sequence classification using exact alignments. Genome Biology 15.

***
## Funding support
Research reported in this publication was supported by grants R01AI141529, R01HD093761, UH3OD023268, U19AI095219, and U01HL089856 from National Institutes of Health. This work was also supported by IBM Research through the AI Horizons Network, UC San Diego AI for Healthy Living program in partnership with the UC San Diego Center for Microbiome Innovation.

## License
MIT License

