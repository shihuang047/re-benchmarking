#Library R packages
library(ggplot2)
library(scales)


##  Bacteria
#Read plot data
Plot.Scatter_Bacteria <-read.table(file = "Simulated_profile_bacteria.txt",header = T,sep="\t", row.names=1)

#Plot
ggplot(Plot.Scatter_Bacteria, aes(x = Taxonomic, y = Sequence)) + geom_point(size=4,aes(colour=Genome_size)) +
  scale_x_log10(name="Taxonomic abundance", breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)),limits=c(1e-4,1e-1)) +
  scale_y_log10(name="Sequence abundance", breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)),limits=c(1e-4,1e-1)) +
  scale_colour_gradient2(low="red",mid="#74D055",high="#3F4788")+
  theme_bw() + annotation_logticks()


##  Fungi
#Read plot data
Plot.Scatter_Fungi <-read.table(file = "Simulated_profile_fungi.txt",header = T,sep="\t", row.names=1)

#Plot
ggplot(Plot.Scatter_Fungi, aes(x = Taxonomic, y = Sequence)) + geom_point(size=4,aes(colour=Genome_size)) +
  scale_x_log10(name="Taxonomic abundance", breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)),limits=c(1e-4,1e-1)) +
  scale_y_log10(name="Sequence abundance", breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)),limits=c(1e-4,1e-1)) +
  scale_colour_gradient2(low="red",mid="#74D055",high="#3F4788")+
  theme_bw() + annotation_logticks()


##  Viral
#Read plot data
Plot.Scatter_Viral <-read.table(file = "Simulated_profile_viral.txt",header = T,sep="\t", row.names=1)

#Plot
ggplot(Plot.Scatter_Viral, aes(x = Taxonomic, y = Sequence)) + geom_point(size=4,aes(colour=Genome_size)) +
  scale_x_log10(name="Taxonomic abundance", breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)),limits=c(1e-4,1e-1)) +
  scale_y_log10(name="Sequence abundance", breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)),limits=c(1e-4,1e-1)) +
  scale_colour_gradient2(low="red",mid="#74D055",high="#3F4788")+
  theme_bw() + annotation_logticks()



##  All
#Read plot data
Plot.Scatter_All <-read.table(file = "Simulated_profile_allmicrobes.txt",header = T,sep="\t", row.names=1)

#Plot
ggplot(Plot.Scatter_All, aes(x = Taxonomic, y = Sequence)) + geom_point(size=4,aes(colour=Genome_size)) +
  scale_x_log10(name="Taxonomic abundance", breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)),limits=c(1e-4,1e-1)) +
  scale_y_log10(name="Sequence abundance", breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x)),limits=c(1e-4,1e-1)) +
  scale_colour_gradient2(low="red",mid="#74D055",high="#3F4788")+
  theme_bw() + annotation_logticks()



