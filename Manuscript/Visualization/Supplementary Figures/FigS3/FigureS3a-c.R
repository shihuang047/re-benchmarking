 #library R packages

    library("ggplot2")
    library("ggsignif")
    library("RColorBrewer")
    auprc <- read.table("Precision_Recall_F1_in_default_output.txt",header = T, sep="\t")

 #plotting
  
    ggplot(data=auprc, aes(x=profilers, y=Precision, fill=profilers))+
      stat_boxplot(geom = "errorbar",width=0.15)+
      geom_boxplot() + theme_bw() +
      scale_fill_manual(values = brewer.pal(8, "Set1")) +
      geom_signif(comparisons = list(c("Bracken","mOTUs2"),c("Bracken","MPA2"),c("Kraken2","mOTUs2"),c("Kraken2","MPA2")),step_increase = 0.1,map_signif_level = T,test = wilcox.test)

    ggplot(data=auprc, aes(x=profilers, y=Recall, fill=profilers))+
      stat_boxplot(geom = "errorbar",width=0.15)+
      geom_boxplot() + theme_bw() +
      scale_fill_manual(values = brewer.pal(8, "Set1")) +
      geom_signif(comparisons = list(c("Bracken","mOTUs2"),c("Bracken","MPA2"),c("Kraken2","mOTUs2"),c("Kraken2","MPA2")),step_increase = 0.1,map_signif_level = T,test = wilcox.test)

    ggplot(data=auprc, aes(x=profilers, y=F1_score, fill=profilers))+
      stat_boxplot(geom = "errorbar",width=0.15)+
      geom_boxplot() + theme_bw() +
      scale_fill_manual(values = brewer.pal(8, "Set1")) +
      geom_signif(comparisons = list(c("Bracken","mOTUs2"),c("Bracken","MPA2"),c("Kraken2","mOTUs2"),c("Kraken2","MPA2")),step_increase = 0.1,map_signif_level = T,test = wilcox.test)
    
    ggplot(data=auprc, aes(x=profilers, y=AUPRC, fill=profilers))+
      stat_boxplot(geom = "errorbar",width=0.15)+
      geom_boxplot() + theme_bw() +
      scale_fill_manual(values = brewer.pal(8, "Set1")) +
      geom_signif(comparisons = list(c("Bracken","mOTUs2"),c("Bracken","MPA2"),c("Kraken2","mOTUs2"),c("Kraken2","MPA2")),step_increase = 0.1,map_signif_level = T,test = wilcox.test)
 
 # For the plotting script for Fig.S3 d-f, please refer to the FigS3d_f.ipynb