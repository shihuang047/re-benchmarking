#Library R packages
library(RColorBrewer)
library(ggplot2)

#Read plot data
Plot.Adiversity <- read.table(file = "Figure4_metadata_and_organized_alpha_diversity.txt",header = T,sep="\t", row.names=1)
Plot.Deviation <- read.table("Deviation_alpha.txt",header = T, row.names = 1,sep="\t")

#Plot
ggplot(data=Plot.Adiversity, aes(x=Abd_type, y=Index, fill=Abd_type))+
  stat_boxplot(geom = "errorbar",width=0.15)+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_boxplot() + theme_bw()+
  facet_wrap(Method~Env, scales = "free", ncol = 5)+
  scale_fill_manual(values = brewer.pal(8, "Set1"))+
  geom_signif(comparisons = list(c("Taxonomic", "Sequence")),
              step_increase = 0.1, map_signif_level = T,
              test = wilcox.test)

ggplot(Plot.Deviation,aes(Seq-Tax))+geom_histogram()+theme_bw()+
  xlab("Sequence abudnance-Taxonomic abundance")+facet_grid(Index~Habitats,scales="free")
