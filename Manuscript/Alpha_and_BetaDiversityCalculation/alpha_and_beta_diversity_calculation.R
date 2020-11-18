###########################################################################
# Function: L1, L2, rJSD, BC distance calculaton based on an input abundance profile
# Call: Rscript Distance_calculation.R input_abundance_matrix
# Last update: 2020-09-01, Zheng Sun 
###########################################################################

setwd('./')

#Args input
args=commandArgs(T)
if(is.na(args[1])) stop("Please input the abundance table")
args[1] #input abundance table
abd <- read.table(args[1],row.names = 1,header = T,sep="\t")

p <- c("vegan")
usePackage <- function(p) {
  if (!is.element(p, installed.packages()[,1]))
    install.packages(p, dep=TRUE, repos="http://cran.us.r-project.org/")
  suppressWarnings(suppressMessages(invisible(require(p, character.only=TRUE))))
}
invisible(lapply(p, usePackage))

#==============rJSD=======================================================
    dist.JSD <- function(inMatrix, pseudocount=0.000001, ...) {
      KLD <- function(x,y) sum(x *log(x/y))
      JSD<- function(x,y) sqrt(0.5 * KLD(x, (x+y)/2) + 0.5 * KLD(y, (x+y)/2))
      matrixColSize <- length(colnames(inMatrix))
      matrixRowSize <- length(rownames(inMatrix))
      colnames <- colnames(inMatrix)
      resultsMatrix <- matrix(0, matrixColSize, matrixColSize)
      
      inMatrix = apply(inMatrix,1:2,function(x) ifelse (x==0,pseudocount,x))
      
      for(i in 1:matrixColSize) {
        for(j in 1:matrixColSize) { 
          resultsMatrix[i,j]=JSD(as.vector(inMatrix[,i]),
                                 as.vector(inMatrix[,j]))
        }
      }
      colnames -> colnames(resultsMatrix) -> rownames(resultsMatrix)
      as.dist(resultsMatrix)->resultsMatrix
      attr(resultsMatrix, "method") <- "dist"
      return(resultsMatrix) 
    }

    rJSD_dist=dist.JSD(abd)

#==============L1,L2,BC===================================================
L1_dist <- vegdist(t(abd),method="manhattan") #L1 distance
L2_dist <- vegdist(t(abd),method="euclidean") #L2 distance
BC_dist <- vegdist(t(abd),method="bray") #BC distance

#==============output=====================================================
write.table(as.matrix(rJSD_dist),file=paste("rJSD_",args[1]),quote=F,row.names=T,col.names = T,sep = "\t")
write.table(as.matrix(L1_dist),file=paste("L1_",args[1]),quote=F,row.names=T,col.names = T,sep = "\t")
write.table(as.matrix(L2_dist),file=paste("L2_",args[1]),quote=F,row.names=T,col.names = T,sep = "\t")
write.table(as.matrix(BC_dist),file=paste("BC_",args[1]),quote=F,row.names=T,col.names = T,sep = "\t")
write.table(diversity(t(abd), "simpson"),file=paste("Simpson_",args[1]),quote=F,row.names=T,col.names = T,sep = "\t")
write.table(diversity(t(abd), "shannon"),file=paste("Shannon_",args[1]),quote=F,row.names=T,col.names = T,sep = "\t")

