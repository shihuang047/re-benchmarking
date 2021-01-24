aa <- read.table("Plot_distribution_tools.txt", row.names=1, header=T, sep = "\t")

ggplot(aa, aes(x = genomic_size, fill = Tools)) + 
  geom_histogram(position="identity", alpha = 0.7, binwidth = 0.1) + 
  scale_x_continuous(limits = c(0,11), breaks = seq(0, 11, 1))+ theme_bw()
