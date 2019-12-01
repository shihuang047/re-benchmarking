# RETHINKING the benchmarking of taxonomic profilers for shotugun metagenomics data

***
## Introduction
Microbial identification and accurate abundance estimation are still challenging in the metagenomics analysis yet poorly understood and evaluated using appropriate metrics. 

**False positive assignment** High FP rate in the microbial identification is among the most critical yet-to-resolve issues of metagenomics (Ye et al., 2019). This problem leads to severe over-estimation of species richness, confounds true signals in the construction of taxonomic and functional profiles, and impairs the efficancy of compositionality-based community analysis.

**Abundance estimation: sequence abundance VS taxonomic abundance** Microbial abundance in the metagenomics data can be considered either as the relative abundance of reads from each taxa (‘‘sequence abundance’’) or by inferring abundance of the number of individuals from each taxa by correcting read counts for genome size (‘‘taxonomic abundance’’). However, such correction for genome length into abundance estimation is usually missed in most state-of-the-art DNA-to-DNA profilers. Even though it can be manually performed by reweighting the read counts after classification, [previous benchmarking studies](https://www.sciencedirect.com/science/article/pii/S0092867419307755) still used raw abundance profiles for performance comparisons , resulting in highly misleading or even contradictory conclusions in the evlaution of profilers.

## Previous benchmarking results
In the [recent paper](https://www.sciencedirect.com/science/article/pii/S0092867419307755) published on CELL, authors review current state-of-the-art approaches for metagenomic analysis and evaluate the performance of 20 metagenomic classifiers by two key metrics (AUPR score and L2 distance) on simulated and experimental datasets.

## RE-benchmarking using differential metrics

![AUPR](NewSim_auprc_bracken-metaplhan2_boxplot.png)
The AUPR score can be calculated using either actual abundance or "binary" abundance. In the [CELL paper](https://www.sciencedirect.com/science/article/pii/S0092867419307755), authors used AUPR which essentially calculated as the area under the precision-recall curve by ranging the actual abundance threshold from 0 to 1.0. However, this AUPR score biased toward low-precision and high-recall classifiers (such as Bracken or Kracken with bigger database), which can’t reflect the high-false-positive issue. 
![L2_dist](NewSim_L2.dist_bracken-metaplhan2_boxplot.png)
The L2 distance between observed abundance and expected abundance, where can be defined by either sequence or taxonomic abundance in the ground truth.

## Reference
* Ye, S.H., Siddle, K.J., Park, D.J., and Sabeti, P.C. (2019). Benchmarking Metagenomics Tools for Taxonomic Classification. Cell 178, 779-794.
