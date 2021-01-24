###########################################################################
# Function: Comparison of the two matrixes using the Mantel test, Procuste test based on Ordination analysis (same sample Name is required) 
# Call: Rscript Matrixes_Comparison.R matrixA matrixB
# Last update: 2020-09-01, Zheng Sun 
###########################################################################

setwd('./')

#Args input
args=commandArgs(T)
if(is.na(args[1])) stop("Please input the matrix A")
if(is.na(args[2])) stop("Please input the matrix B")
args[1] #input abundance table A
args[2] #input abundance table B

distA <- read.table(args[1],row.names = 1,header = T,sep="\t")
distB <- read.table(args[2],row.names = 1,header = T,sep="\t")

p <- c("vegan","Rtsne","umap","ape","ade4")
usePackage <- function(p) {
  if (!is.element(p, installed.packages()[,1]))
    install.packages(p, dep=TRUE, repos="http://cran.us.r-project.org/")
  suppressWarnings(suppressMessages(invisible(require(p, character.only=TRUE))))
}
invisible(lapply(p, usePackage))
#=======Mantel test for the two distance table/matrixes 
AB_mantel <- mantel(distA,distB,method = "spearman", permutations = 9999, na.rm = TRUE)
print(paste("Mantel statistic r (based on Spearman) is ",AB_mantel$statistic,", p-value is: ",AB_mantel$signif,sep=""))

#========NMDS and procuste test
observed_nmds <- c()
pvalue_nmds <- c()
for(i in 1:11) { 
  A_mds <- monoMDS(distA)
  B_mds <- monoMDS(distB)
  NMDS_procuste <- procuste(A_mds$points, B_mds$points)
  NMDS.Mtest <- randtest(NMDS_procuste, 9999)
  observed_nmds <- c(observed_nmds,NMDS.Mtest$obs)
  pvalue_nmds <- c (pvalue_nmds,NMDS.Mtest$pvalue)
}
write.table(cbind(NMDS_procuste$tabX,NMDS_procuste$rotY),file="Original_and_adjusted_NMDSpoints.txt",row.names = T,col.names = T,quote=F,sep="\t")
print(paste("Median observed similarity of 101 times NMDS is: ",median(observed_nmds), ", p-value is: ",pvalue_nmds[which(observed_nmds == median(observed_nmds))],sep=""))

#========PCoA and procuste test
  A_pcoa <- pcoa(distA)
  B_pcoa <- pcoa(distB)
  PCOA_procuste <- procuste(A_pcoa$vectors[,1:2], B_pcoa$vectors[,1:2])
  PCOA.Mtest <- randtest(PCOA_procuste, 9999)
write.table(cbind(PCOA_procuste$tabX,PCOA_procuste$rotY),file="Original_and_adjusted_PCOApoints.txt",row.names = T,col.names = T,quote=F,sep="\t")
print(paste("Observed similarity of PCoA is: ",PCOA.Mtest$obs, ", p-value is: ",PCOA.Mtest$pvalue,sep=""))

#========t-SNE and procuste test
observed_tsne <- c()
pvalue_tsne <- c()
for(i in 1:11) { 
  A_tsne <- Rtsne(distA, theta=0.0)
  B_tsne <- Rtsne(distB, theta=0.0)
  TSNE_procuste <- procuste(A_tsne $Y, B_tsne $Y)
  TSNE.Mtest <- randtest(TSNE_procuste, 9999)
  observed_tsne <- c(observed_tsne,TSNE.Mtest$obs)
  pvalue_tsne <- c (pvalue_tsne,TSNE.Mtest$pvalue)
}
write.table(cbind(TSNE_procuste$tabX,TSNE_procuste$rotY),file="Original_and_adjusted_tSNEpoints.txt",row.names = T,col.names = T,quote=F,sep="\t")
print(paste("Median observed similarity of 101 times tSNE is: ",median(observed_tsne), ", p-value is: ",pvalue_tsne [which(observed_tsne == median(observed_tsne ))],sep=""))

#========UMAP and procuste test
observed_umap <- c()
pvalue_umap <- c()
for(i in 1:11) { 
  A_umap <- umap(as.matrix(distA))
  B_umap <- umap(as.matrix(distB))
  UMAP_procuste <- procuste(A_umap$layout, B_umap$layout)
  UMAP.Mtest <- randtest(UMAP_procuste, 9999)
  observed_umap <- c(observed_umap,UMAP.Mtest$obs)
  pvalue_umap <- c (pvalue_umap,UMAP.Mtest$pvalue)
}
write.table(cbind(UMAP_procuste$tabX,UMAP_procuste$rotY),file="Original_and_adjusted_UMAPpoints.txt",row.names = T,col.names = T,quote=F,sep="\t")
print(paste("Median observed similarity of 101 times UMAP is: ",median(observed_umap), ", p-value is: ",pvalue_umap[which(observed_umap== median(observed_umap))],sep=""))





