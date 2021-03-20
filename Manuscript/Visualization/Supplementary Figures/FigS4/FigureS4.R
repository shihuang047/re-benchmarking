####	PCOA
#Lirary R packages
library(RColorBrewer)
library(ggplot2)
library(ggpubr)

#Read table
Plot.PCOA_BC.building <-read.table(file = "PCOA_BC_building.txt",header = T,sep="\t",row.names=1)
Plot.PCOA_BC.gut <-read.table(file = "PCOA_BC_gut.txt",header = T,sep="\t",row.names=1)
Plot.PCOA_BC.oral <-read.table(file = "PCOA_BC_oral.txt",header = T,sep="\t",row.names=1)
Plot.PCOA_BC.skin <-read.table(file = "PCOA_BC_skin.txt",header = T,sep="\t",row.names=1)
Plot.PCOA_BC.vaginal <-read.table(file = "PCOA_BC_vaginal.txt",header = T,sep="\t",row.names=1)

#Plot
p.PCOA_BC.building <- ggplot(data=Plot.PCOA_BC.building, aes(x=PCOA1, y=PCOA2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="PCOA_building") + xlab("PCOA1") + ylab("PCOA2")
p.PCOA_BC.gut <- ggplot(data=Plot.PCOA_BC.gut, aes(x=PCOA1, y=PCOA2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="PCOA_gut") + xlab("PCOA1") + ylab("PCOA2")
p.PCOA_BC.oral <- ggplot(data=Plot.PCOA_BC.oral, aes(x=PCOA1, y=PCOA2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="PCOA_oral") + xlab("PCOA1") + ylab("PCOA2")
p.PCOA_BC.skin <- ggplot(data=Plot.PCOA_BC.skin, aes(x=PCOA1, y=PCOA2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="PCOA_skin") + xlab("PCOA1") + ylab("PCOA2")
p.PCOA_BC.vaginal<- ggplot(data=Plot.PCOA_BC.vaginal, aes(x=PCOA1, y=PCOA2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="PCOA_vaginal") + xlab("PCOA1") + ylab("PCOA2")

#Combine the figure of different environment
p.PCOA_BC <- ggarrange(p.PCOA_BC.building, p.PCOA_BC.gut, p.PCOA_BC.oral, p.PCOA_BC.skin, p.PCOA_BC.vaginal,
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
Plot.NMDS_BC.building <-read.table(file = "NMDS_BC_building.txt",header = T,sep="\t",row.names=1)
Plot.NMDS_BC.gut <-read.table(file = "NMDS_BC_gut.txt",header = T,sep="\t",row.names=1)
Plot.NMDS_BC.oral <-read.table(file = "NMDS_BC_oral.txt",header = T,sep="\t",row.names=1)
Plot.NMDS_BC.skin <-read.table(file = "NMDS_BC_skin.txt",header = T,sep="\t",row.names=1)
Plot.NMDS_BC.vaginal <-read.table(file = "NMDS_BC_vaginal.txt",header = T,sep="\t",row.names=1)

#Plot
p.NMDS_BC.building <- ggplot(data=Plot.NMDS_BC.building, aes(x=NMDS1, y=NMDS2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="NMDS_building") + xlab("NMDS1") + ylab("NMDS2")
p.NMDS_BC.gut <- ggplot(data=Plot.NMDS_BC.gut, aes(x=NMDS1, y=NMDS2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="NMDS_gut") + xlab("NMDS1") + ylab("NMDS2")
p.NMDS_BC.oral <- ggplot(data=Plot.NMDS_BC.oral, aes(x=NMDS1, y=NMDS2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="NMDS_oral") + xlab("NMDS1") + ylab("NMDS2")
p.NMDS_BC.skin <- ggplot(data=Plot.NMDS_BC.skin, aes(x=NMDS1, y=NMDS2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="NMDS_skin") + xlab("NMDS1") + ylab("NMDS2")
p.NMDS_BC.vaginal<- ggplot(data=Plot.NMDS_BC.vaginal, aes(x=NMDS1, y=NMDS2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="NMDS_vaginal") + xlab("NMDS1") + ylab("NMDS2")

#Combine the figure of different environment
p.NMDS_BC <- ggarrange(p.NMDS_BC.building, p.NMDS_BC.gut, p.NMDS_BC.oral, p.NMDS_BC.skin, p.NMDS_BC.vaginal,
                              nrow = 5, ncol = 1)

####	t_SNE
#Lirary R packages
library(Rtsne)
library(ade4)
library(RColorBrewer)
library(ggplot2)
library(ggpubr)

#Read table
Plot.t_SNE_BC.building <-read.table(file = "t_SNE_BC_building.txt",header = T,sep="\t",row.names=1)
Plot.t_SNE_BC.gut <-read.table(file = "t_SNE_BC_gut.txt",header = T,sep="\t",row.names=1)
Plot.t_SNE_BC.oral <-read.table(file = "t_SNE_BC_oral.txt",header = T,sep="\t",row.names=1)
Plot.t_SNE_BC.skin <-read.table(file = "t_SNE_BC_skin.txt",header = T,sep="\t",row.names=1)
Plot.t_SNE_BC.vaginal <-read.table(file = "t_SNE_BC_vaginal.txt",header = T,sep="\t",row.names=1)

#Plot
p.t_SNE_BC.building <- ggplot(data=Plot.t_SNE_BC.building, aes(x=t_SNE1, y=t_SNE2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="t_SNE_building") + xlab("t_SNE1") + ylab("t_SNE2")
p.t_SNE_BC.gut <- ggplot(data=Plot.t_SNE_BC.gut, aes(x=t_SNE1, y=t_SNE2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="t_SNE_gut") + xlab("t_SNE1") + ylab("t_SNE2")
p.t_SNE_BC.oral <- ggplot(data=Plot.t_SNE_BC.oral, aes(x=t_SNE1, y=t_SNE2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="t_SNE_oral") + xlab("t_SNE1") + ylab("t_SNE2")
p.t_SNE_BC.skin <- ggplot(data=Plot.t_SNE_BC.skin, aes(x=t_SNE1, y=t_SNE2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="t_SNE_skin") + xlab("t_SNE1") + ylab("t_SNE2")
p.t_SNE_BC.vaginal<- ggplot(data=Plot.t_SNE_BC.vaginal, aes(x=t_SNE1, y=t_SNE2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="t_SNE_vaginal") + xlab("t_SNE1") + ylab("t_SNE2")

#Combine the figure of different environment
p.t_SNE_BC <- ggarrange(p.t_SNE_BC.building, p.t_SNE_BC.gut, p.t_SNE_BC.oral, p.t_SNE_BC.skin, p.t_SNE_BC.vaginal,
                              nrow = 5, ncol = 1)

####	UMAP
#Lirary R packages
library(umap)
library(ade4)
library(RColorBrewer)
library(ggplot2)
library(ggpubr)

#Read table
Plot.UMAP_BC.building <-read.table(file = "UMAP_BC_building.txt",header = T,sep="\t",row.names=1)
Plot.UMAP_BC.gut <-read.table(file = "UMAP_BC_gut.txt",header = T,sep="\t",row.names=1)
Plot.UMAP_BC.oral <-read.table(file = "UMAP_BC_oral.txt",header = T,sep="\t",row.names=1)
Plot.UMAP_BC.skin <-read.table(file = "UMAP_BC_skin.txt",header = T,sep="\t",row.names=1)
Plot.UMAP_BC.vaginal <-read.table(file = "UMAP_BC_vaginal.txt",header = T,sep="\t",row.names=1)

#Plot
p.UMAP_BC.building <- ggplot(data=Plot.UMAP_BC.building, aes(x=UMAP1, y=UMAP2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="UMAP_building") + xlab("UMAP1") + ylab("UMAP2")
p.UMAP_BC.gut <- ggplot(data=Plot.UMAP_BC.gut, aes(x=UMAP1, y=UMAP2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="UMAP_gut") + xlab("UMAP1") + ylab("UMAP2")
p.UMAP_BC.oral <- ggplot(data=Plot.UMAP_BC.oral, aes(x=UMAP1, y=UMAP2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="UMAP_oral") + xlab("UMAP1") + ylab("UMAP2")
p.UMAP_BC.skin <- ggplot(data=Plot.UMAP_BC.skin, aes(x=UMAP1, y=UMAP2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="UMAP_skin") + xlab("UMAP1") + ylab("UMAP2")
p.UMAP_BC.vaginal<- ggplot(data=Plot.UMAP_BC.vaginal, aes(x=UMAP1, y=UMAP2, colour=Abd_type))+
  geom_line(aes(group=SampleID), colour='Gray75', size=0.75)+
  geom_point(size=4, position="identity", alpha = 0.8)+
  theme_bw()+
  scale_colour_manual(values = brewer.pal(8, "Set1"))+
  labs(title="UMAP_vaginal") + xlab("UMAP1") + ylab("UMAP2")

#Combine the figure of different environment
p.UMAP_BC <- ggarrange(p.UMAP_BC.building, p.UMAP_BC.gut, p.UMAP_BC.oral, p.UMAP_BC.skin, p.UMAP_BC.vaginal,
                              nrow = 5, ncol = 1)
