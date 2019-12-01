# RETHINKING the benchmarking of taxonomic profilers for shotugun metagenomics data

***
## Introduction
Microbial identification and accurate abundance estimation are still challenging in the metagenomics analysis yet poorly understood and evaluated using appropriate metrics. 
**False positive assignment** High FP rate in the microbial identification is among the most critical yet-to-resolve issues of metagenomics (Ye et al., 2019). This problem leads to severe over-estimation of species richness, confounds true signals in the construction of taxonomic and functional profiles, and impairs the efficancy of compositionality-based community analysis.
**Abundance estimation: sequence abundance VS taxonomic abundance** Microbial abundance in the metagenomics data can be considered either as the relative abundance of reads from each taxa (‘‘sequence abundance’’) or by inferring abundance of the number of individuals from each taxa by correcting read counts for genome size (‘‘taxonomic abundance’’). However, such correction for genome length into abundance estimation is usually missed in most state-of-the-art DNA-to-DNA profilers. Even though it can be manually performed by reweighting the read counts after classification, most benchmarking works still used raw abundance profiles for performance comparisons, resulting in highly misleading or even contradictory conclusions in the evlaution of profilers.

## Authors ##


## Benchmarking ##


## Reference ##
