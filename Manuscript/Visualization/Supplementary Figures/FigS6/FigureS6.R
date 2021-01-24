####	PCOA
#Lirary R packages
library(RColorBrewer)
library(ggplot2)
library(ggpubr)

#Read table
Plot.PCOA_rAD.building <-read.table(file = "PCOA_rAD_building.txt",header = T,sep="\t",row.names=1)
Plot.PCOA_rAD.gut <-read.table(file = "PCOA_rAD_gut.txt",header = T,sep="\t",row.names=1)
Plot.PCOA_rAD.oral <-read.table(file = "PCOA_rAD_oral.txt",header = T,sep="\t",row.names=1)
Plot.PCOA_rAD.skin <-read.table(file = "PCOA_rAD_skin.txt",header = T,sep="\t",row.names=1)
Plot.PCOA_rAD.vaginal <-read.table(file = "PCOA_rAD_vaginal.txt",header = T,sep="\t",row.names=1)

#Plot
p.PCOA_rAD.building <- ggplot(data=Plot.PCOA_rAD.building, aes(x=PCOA1, y=PCOA2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="PCOA_building") + xlab("PCOA1") + ylab("PCOA2")
p.PCOA_rAD.gut <- ggplot(data=Plot.PCOA_rAD.gut, aes(x=PCOA1, y=PCOA2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="PCOA_gut") + xlab("PCOA1") + ylab("PCOA2")
p.PCOA_rAD.oral <- ggplot(data=Plot.PCOA_rAD.oral, aes(x=PCOA1, y=PCOA2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="PCOA_oral") + xlab("PCOA1") + ylab("PCOA2")
p.PCOA_rAD.skin <- ggplot(data=Plot.PCOA_rAD.skin, aes(x=PCOA1, y=PCOA2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="PCOA_skin") + xlab("PCOA1") + ylab("PCOA2")
p.PCOA_rAD.vaginal<- ggplot(data=Plot.PCOA_rAD.vaginal, aes(x=PCOA1, y=PCOA2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="PCOA_vaginal") + xlab("PCOA1") + ylab("PCOA2")

#Combine the figure of different environment
p.PCOA_rAD <- ggarrange(p.PCOA_rAD.building, p.PCOA_rAD.gut, p.PCOA_rAD.oral, p.PCOA_rAD.skin, p.PCOA_rAD.vaginal,
                              nrow = 5, ncol = 1)

####	NMDS

#Lirary R packages
library(tidyverse)
library(ade4)
library(vegan)
library(RColorBrewer)
library(ggplot2)
library(ggpubr)

#Read table
Plot.NMDS_rAD.building <-read.table(file = "NMDS_rAD_building.txt",header = T,sep="\t",row.names=1)
Plot.NMDS_rAD.gut <-read.table(file = "NMDS_rAD_gut.txt",header = T,sep="\t",row.names=1)
Plot.NMDS_rAD.oral <-read.table(file = "NMDS_rAD_oral.txt",header = T,sep="\t",row.names=1)
Plot.NMDS_rAD.skin <-read.table(file = "NMDS_rAD_skin.txt",header = T,sep="\t",row.names=1)
Plot.NMDS_rAD.vaginal <-read.table(file = "NMDS_rAD_vaginal.txt",header = T,sep="\t",row.names=1)

#Plot
p.NMDS_rAD.building <- ggplot(data=Plot.NMDS_rAD.building, aes(x=NMDS1, y=NMDS2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="NMDS_building") + xlab("NMDS1") + ylab("NMDS2")
p.NMDS_rAD.gut <- ggplot(data=Plot.NMDS_rAD.gut, aes(x=NMDS1, y=NMDS2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="NMDS_gut") + xlab("NMDS1") + ylab("NMDS2")
p.NMDS_rAD.oral <- ggplot(data=Plot.NMDS_rAD.oral, aes(x=NMDS1, y=NMDS2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="NMDS_oral") + xlab("NMDS1") + ylab("NMDS2")
p.NMDS_rAD.skin <- ggplot(data=Plot.NMDS_rAD.skin, aes(x=NMDS1, y=NMDS2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="NMDS_skin") + xlab("NMDS1") + ylab("NMDS2")
p.NMDS_rAD.vaginal<- ggplot(data=Plot.NMDS_rAD.vaginal, aes(x=NMDS1, y=NMDS2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="NMDS_vaginal") + xlab("NMDS1") + ylab("NMDS2")

#Combine the figure of different environment
p.NMDS_rAD <- ggarrange(p.NMDS_rAD.building, p.NMDS_rAD.gut, p.NMDS_rAD.oral, p.NMDS_rAD.skin, p.NMDS_rAD.vaginal,
                              nrow = 5, ncol = 1)

####	t_SNE
#Lirary R packages
library(Rtsne)
library(ade4)
library(RColorBrewer)
library(ggplot2)
library(ggpubr)

#Read table
Plot.t_SNE_rAD.building <-read.table(file = "t_SNE_rAD_building.txt",header = T,sep="\t",row.names=1)
Plot.t_SNE_rAD.gut <-read.table(file = "t_SNE_rAD_gut.txt",header = T,sep="\t",row.names=1)
Plot.t_SNE_rAD.oral <-read.table(file = "t_SNE_rAD_oral.txt",header = T,sep="\t",row.names=1)
Plot.t_SNE_rAD.skin <-read.table(file = "t_SNE_rAD_skin.txt",header = T,sep="\t",row.names=1)
Plot.t_SNE_rAD.vaginal <-read.table(file = "t_SNE_rAD_vaginal.txt",header = T,sep="\t",row.names=1)

#Plot
p.t_SNE_rAD.building <- ggplot(data=Plot.t_SNE_rAD.building, aes(x=t_SNE1, y=t_SNE2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="t_SNE_building") + xlab("t_SNE1") + ylab("t_SNE2")
p.t_SNE_rAD.gut <- ggplot(data=Plot.t_SNE_rAD.gut, aes(x=t_SNE1, y=t_SNE2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="t_SNE_gut") + xlab("t_SNE1") + ylab("t_SNE2")
p.t_SNE_rAD.oral <- ggplot(data=Plot.t_SNE_rAD.oral, aes(x=t_SNE1, y=t_SNE2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="t_SNE_oral") + xlab("t_SNE1") + ylab("t_SNE2")
p.t_SNE_rAD.skin <- ggplot(data=Plot.t_SNE_rAD.skin, aes(x=t_SNE1, y=t_SNE2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="t_SNE_skin") + xlab("t_SNE1") + ylab("t_SNE2")
p.t_SNE_rAD.vaginal<- ggplot(data=Plot.t_SNE_rAD.vaginal, aes(x=t_SNE1, y=t_SNE2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="t_SNE_vaginal") + xlab("t_SNE1") + ylab("t_SNE2")

#Combine the figure of different environment
p.t_SNE_rAD <- ggarrange(p.t_SNE_rAD.building, p.t_SNE_rAD.gut, p.t_SNE_rAD.oral, p.t_SNE_rAD.skin, p.t_SNE_rAD.vaginal,
                              nrow = 5, ncol = 1)

####	UMAP
#Lirary R packages
library(umap)
library(ade4)
library(RColorBrewer)
library(ggplot2)
library(ggpubr)

#Read table
Plot.UMAP_rAD.building <-read.table(file = "UMAP_rAD_building.txt",header = T,sep="\t",row.names=1)
Plot.UMAP_rAD.gut <-read.table(file = "UMAP_rAD_gut.txt",header = T,sep="\t",row.names=1)
Plot.UMAP_rAD.oral <-read.table(file = "UMAP_rAD_oral.txt",header = T,sep="\t",row.names=1)
Plot.UMAP_rAD.skin <-read.table(file = "UMAP_rAD_skin.txt",header = T,sep="\t",row.names=1)
Plot.UMAP_rAD.vaginal <-read.table(file = "UMAP_rAD_vaginal.txt",header = T,sep="\t",row.names=1)

#Plot
p.UMAP_rAD.building <- ggplot(data=Plot.UMAP_rAD.building, aes(x=UMAP1, y=UMAP2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="UMAP_building") + xlab("UMAP1") + ylab("UMAP2")
p.UMAP_rAD.gut <- ggplot(data=Plot.UMAP_rAD.gut, aes(x=UMAP1, y=UMAP2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="UMAP_gut") + xlab("UMAP1") + ylab("UMAP2")
p.UMAP_rAD.oral <- ggplot(data=Plot.UMAP_rAD.oral, aes(x=UMAP1, y=UMAP2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="UMAP_oral") + xlab("UMAP1") + ylab("UMAP2")
p.UMAP_rAD.skin <- ggplot(data=Plot.UMAP_rAD.skin, aes(x=UMAP1, y=UMAP2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="UMAP_skin") + xlab("UMAP1") + ylab("UMAP2")
p.UMAP_rAD.vaginal<- ggplot(data=Plot.UMAP_rAD.vaginal, aes(x=UMAP1, y=UMAP2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="UMAP_vaginal") + xlab("UMAP1") + ylab("UMAP2")

#Combine the figure of different environment
p.UMAP_rAD <- ggarrange(p.UMAP_rAD.building, p.UMAP_rAD.gut, p.UMAP_rAD.oral, p.UMAP_rAD.skin, p.UMAP_rAD.vaginal,
                              nrow = 5, ncol = 1)
