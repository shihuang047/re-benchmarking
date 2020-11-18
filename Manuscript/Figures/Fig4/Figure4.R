#Library R packages
library(RColorBrewer)
library(ggplot2)

#Read plot data
Plot.Fig4 <- read.table("Figure4_metadata_and_organized_metrics.txt", header=T, sep = "\t")

#Plot
ggplot(data=Plot.Fig4 ,aes(x=Species_num, y=Distance, color=Matrix))+
  geom_point(size=1)+
  geom_smooth(level = 0.95)+
  theme_bw() + facet_wrap(~Matrix, scales = "free")
