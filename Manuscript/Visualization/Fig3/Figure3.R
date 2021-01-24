#Library R packages
library(RColorBrewer)
library(ggplot2)
library(ggsignif)

#Read plot data
Plot.Fig3 <-read.table(file = "Figure3_metadata_and_organized_metrics.txt",header = T,sep="\t", row.names=1)

#Plot
ggplot(data=Plot.Fig3, aes(x=Profilers, y=Distance, fill=Profilers))+
  stat_boxplot(geom = "errorbar", colour="black", width=0.5)+
  geom_point(aes(x=Profilers, y=Distance, color=Colour))+
  geom_boxplot() + theme_bw() + facet_grid(Matrix~Compared_with, scales = "free")+
  geom_signif(comparisons = list(c("Kraken2","mOTUs2"), c("Kraken2","MPA2"),
                                 c("Bracken","mOTUs2"), c("Bracken","MPA2")),
              step_increase = 0.1, map_signif_level = T, test = wilcox.test)+
  scale_fill_manual(values = brewer.pal(7, "Set1"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))
