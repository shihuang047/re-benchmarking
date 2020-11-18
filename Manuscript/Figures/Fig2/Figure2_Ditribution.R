#Library R packages
library(ggplot2)

#Read plot data
Plot.Distribution <- read.table("Genome_size_NCBI_RefSeq.txt", header = T, sep = "\t")

#Plot
ggplot(Plot.Distribution, aes(x = Genome_sizeM, fill = Superkingdom)) + 
  geom_histogram(position="identity", alpha = 0.7, binwidth = 0.1) + 
  scale_x_continuous(limits = c(0,11), breaks = seq(0, 11, 1)) + 
  ylim(0,500) + theme_bw()
