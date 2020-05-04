# RETHINKING benchmarking metagenomics classifers

This repo contains the code to reproduce all of the analyses in the paper "Pitfalls and opportunities in benchmarking metagenomic classifiers" by Zheng, Huang et al. 2020.

The raw data is available on figshare: https://figshare.com/projects/Pitfalls_and_Opportunities_in_Benchmarking_Metagenomic_Classifiers/79916

***
## The motivations
Microbial identification and accurate abundance estimation are still challenging in the metagenomics analysis yet poorly understood and evaluated using appropriate metrics or ground truth data. 

**Abundance estimation: sequence abundance VS taxonomic abundance** Microbial abundance in the metagenomics data can be considered either as the relative abundance of reads from each taxa ("sequence abundance") or by inferring abundance of the number of individuals from each taxa by correcting read counts for genome size ("taxonomic abundance"). However, such correction for genome length into abundance estimation is usually missed in most state-of-the-art profilers. Even though it can be manually performed by reweighting the read counts after classification, [previous benchmarking studies](https://www.sciencedirect.com/science/article/pii/S0092867419307755) did not perform appropriate corrections and still used "raw" abundance profiles generated from benchmarked profilers for performance comparisons , resulting in highly misleading or even contradictory conclusions.


## RE-benchmarking
### Data simulation with both taxonomic abundance and sequence abundance as ground truth.
We employed [Wgsim](https://github.com/lh3/wgsim) to simulate metagenomics data with a given number of genomes.
Wgsim is originally a small tool for simulating sequence reads from a reference genome. Here we mixed the genomic sequences from multiple microbial taxa at certain percentages in a fasta file and then took it as input for Wgsim.

### Neglecting the difference between "taxonomic abundance" and "sequence abundance" resulted in very misleading benchmarking results.
In the previous benchmarking study, the L2 distance was calculated between observed and expected abundance profiles. Notably, abundance here can be calculated either as the relative abundance of sequencing reads from microbial taxa or the relative abundance of individuals from a given microbial taxa. In the [CELL paper](https://www.sciencedirect.com/science/article/pii/S0092867419307755), the ground-truth abundance was sequence abundance, whereas a raw abundance profile generated by benchmarked metagenomics tools can be either sequence abundance (such as Bracken, Kracken) or taxonomic abundance (MetaPhlAn2). This inconsistence in the output abudance profiles across metagenomics classifiers largely affect or mislead the benchmarking results, where Bracken typically outperform others.
Here, we rebenchmarked the metagenomics tools on the simulation datasets with known genome size so that we can compare the performance of abundance estimation across metagenomics tools under the context of either sequence abundance and taxonomic abundance. We found that if the sequence abundance was used as ground truth to compare the performance of these two tools, Bracken outperforms MetaPhlAn2, however if taxonomic abundance was used as ground truth, MetaPhlAn2 is better than Bracken. Therefore, the normalization of raw abudance profiles from metagnomics tools may faciliate a more comprehensive benchmarking.

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

