#' ---
#' title: "Benchmarking of taxonmic profilers using AUPR score and L2 distance"
#' author: "ShiHuang"
#' date: "11/19/2019"
#' output: html_document
#' ---

#' Install and load necessary libraries for data analyses
#'-------------------------------
p <- c("reshape2","ggplot2","pheatmap","combinat","plyr", "doMC", "cowplot", "pROC", "readxl", "precrec")
usePackage <- function(p) {
  if (!is.element(p, installed.packages()[,1]))
    install.packages(p, dep=TRUE, repos="https://cloud.r-project.org/")
  suppressWarnings(suppressMessages(invisible(require(p, character.only=TRUE))))
}
invisible(lapply(p, usePackage))
setwd("/Users/huangshi/MyProjects/2b-RAD/re-benchmarking")


#' Transformers
#' -------------------------------
#' IIb_transformer
IIb_output_file="./NewSimDatasets_Results/010.IIB.xls"
IIb_transformer<-function(IIb_output_file){
  IIb_output<-read.table(IIb_output_file, sep="\t", header=TRUE, skip=1)
  IIb_output<-subset(IIb_output, IIb_output$G_Score>20)
  IIb_output[, "Sequenced_Reads_Num.Theoretical_Tag_Num"]<-100*(IIb_output[, "Sequenced_Reads_Num.Theoretical_Tag_Num"]/sum(IIb_output[, "Sequenced_Reads_Num.Theoretical_Tag_Num"]))
  observed_tab<-IIb_output[, c("Specie", "Sequenced_Reads_Num.Theoretical_Tag_Num")]
  colnames(observed_tab)<-c("taxID", "observed_abd")
  observed_tab$observed_abd<-observed_tab$observed_abd/100
  observed_tab
}
IIb_transformer(IIb_output_file)
IIb_output_files<-list.files("IIB.xls", path = "./NewSimDatasets_Results/")
IIb_list<-list()
IIb_list<-lapply(IIb_output_files, function(x) IIb_transformer(paste("./NewSimDatasets_Results/", x,sep="")))
#'bracken_transformer
bracken_output_file="./NewSimDatasets_Results/simulate_010_bracken.kreport"
bracken_transformer<-function(bracken_output_file, RANK="S"){
  braken_columns = c('observed_abd', 'lca_read_count', 'read_count', 'rank',
                    'taxID', 'taxname')
  bracken_output<-read.table(bracken_output_file, sep="\t", header=F)
  colnames(bracken_output)<-braken_columns
  observed_tab<-subset(bracken_output, rank==RANK)[, c("taxID", "observed_abd")]
  observed_tab$observed_abd<-observed_tab$observed_abd/100
  observed_tab
}
bracken_output_files<-list.files("bracken.kreport", path = "NewSimDatasets_Results/")
bracken_list<-list()
bracken_list<-lapply(bracken_output_files, function(x) bracken_transformer(paste("NewSimDatasets_Results/", x,sep="")))
#'mpa2_transformer
mpa2_output_file="./NewSimDatasets_Results/simulate_010_mpa2.txt"
mpa2_taxname_dic_file<-"./SimDatasets5_truth_results/mpa2_taxname_dic.txt"
mpa2_transformer<-function(mpa2_output_file){
  #mpa2_taxname_dic<-read.table(mpa2_taxname_dic_file, sep="\t", header=TRUE)
  #mpa2_taxname_dic2<-mpa2_taxname_dic[, c("mpa2_name", "taxid")]
  #na_idx<-which(is.na(mpa2_taxname_dic2$mpa2_name))
  #mpa2_taxname_dic2$mpa2_name[is.na(mpa2_taxname_dic2$mpa2_name)]<-"NA" #paste("NA", seq_along(1:length(na_idx)), sep = "")
  mpa2_output<-read.table(mpa2_output_file, sep="\t", header=TRUE, comment.char = "")
  #mpa2_output<-merge(mpa2_taxname_dic2, mpa2_output, by=c(1, 1), all.y=T)
  colnames(mpa2_output)<-c("taxID", "taxname", "observed_abd")
  observed_tab<-mpa2_output
  observed_tab$observed_abd<-observed_tab$observed_abd/100
  observed_tab
}
mpa2_transformer(mpa2_output_file)
mpa2_output_files<-list.files("mpa2.txt", path = "./NewSimDatasets_Results/")
mpa2_list<-list()
mpa2_list<-lapply(mpa2_output_files, function(x) mpa2_transformer(paste("./NewSimDatasets_Results/", x,sep="")))

#' Expected abundance data input from xlsx
#'-------------------------------
exp_xlsx_file="NewSimDatasets_Groundtruth_summ_11222019.xlsx"
sheets<-excel_sheets(exp_xlsx_file)
#sheets<-sheets[-1]
exp_list<-list()
for(i in 1:length(sheets)){
  exp_list[[i]]<-data.frame(read_xlsx(exp_xlsx_file, sheet=sheets[i]))
}
exp_transformer<-function(exp_file){
  # exp<-read.table(exp_file, sep="\t", header=F)
  exp<-exp_file[, c("taxID", "exp_taxonomy_abd", "exp_sequence_abd")]
  #colnames(exp)[1]<-"taxID"
  exp
}
exp_tab_list<-lapply(exp_list, exp_transformer)
#exp<-do.call(rbind, exp_list)


#' get.perf.from.tabs: AUPRC and L2 distance calculation
#'-------------------------------
#' @title get.perf.from.tabs
#' 
#' @description AUPRC and L2 distance calculation
#' 
#' @param expected_tab
#' 
#' @param observed_tab
#' 
#' @return 
#' 
#' @example 
#' 
#' expected_tab<-data.frame(taxID=c("123", "12", "39", "28"), 
#'                          exp_sequence_abd=c(0.4, 0.3, 0.2, 0.1))
#' observed_tab0<-data.frame(taxID=c("12", "1", "39", "28"), 
#'                          observed_abd=c(0, 0.3, 0.7, 0))
#' get.perf.from.tabs(expected_tab, observed_tab0)
#' observed_tab<-data.frame(taxID=c("123", "39", "28"), 
#'                          observed_abd=c(0, 0.5, 0.5))
#' get.perf.from.tabs(expected_tab, observed_tab)
#' 
get.perf.from.tabs<-function(expected_tab, observed_tab){
  if(!ncol(expected_tab)>=2 | !ncol(observed_tab)>=2)
    stop("The input tables should have at least two columns!")
  if(!'exp_sequence_abd' %in% colnames(expected_tab))
    stop("The input expected tables should have the column of 'exp_sequence_abd' !")
  if(!'taxID' %in% colnames(expected_tab) | !'taxID' %in% colnames(observed_tab))
    stop("The input expected and observed tables should have the column of 'taxID' !")
  #if(all(range(expected_tab$exp_taxonomy_abd)<1)) expected_tab$exp_taxonomy_abd<-expected_tab$exp_taxonomy_abd*100
  #if(all(range(expected_tab$exp_sequence_abd)<1)) expected_tab$exp_sequence_abd<-expected_tab$exp_sequence_abd*100
  
  conf<-merge(expected_tab, observed_tab, all = TRUE)
  conf<-subset(conf, observed_abd>0)
  
  conf$bi_exp_sequence_abd<-as.integer(!is.na(conf$exp_sequence_abd))
  conf$bi_exp_taxonomy_abd<-as.integer(!is.na(conf$exp_taxonomy_abd))
  conf$bi_observed_abd<-as.integer(!is.na(conf$observed_abd))
  conf$exp_sequence_abd[is.na(conf$exp_sequence_abd)]<-0
  conf$exp_taxonomy_abd[is.na(conf$exp_taxonomy_abd)]<-0
  conf$observed_abd[is.na(conf$observed_abd)]<-0
  if(all(conf$bi_exp_sequence_abd==1)){
    sim_neg<-c(0, 0, 0, 0, 0)
    conf<-rbind(conf, sim_neg)
  }
  sscurves_bi <- evalmod(scores = conf$bi_observed_abd, labels = conf$bi_exp_sequence_abd, na_worst = TRUE)
  sscurves_abd <- evalmod(scores = conf$observed_abd, labels = conf$bi_exp_sequence_abd, na_worst = TRUE)
  #sscurves_abd_all <- evalmod(scores = conf$observed_abd, labels = conf$sequence_abd)
  auc_res_bi<-auc(sscurves_bi)
  auc_res_abd<-auc(sscurves_abd)
  # abundance-estimation metrics
  L2<-function(x, y){
    d<-x-y
    sqrt(sum(d^2, na.rm=T))
  }
  rJSD <- function(x, y){
    if(any(x>1, na.rm=T) && any(y>1, na.rm=T)) 
      x<-x/100; y<-y/100
    z <- 0.5 * (x + y) 
    out<- sqrt(0.5 * (sum(x * log(x / z), na.rm=T) + sum(y * log(y / z), na.rm=T)))
    return(out)
  }
  abd_metrics<-function(conf){
    conf_seq<-data.frame(conf[,c("exp_sequence_abd","observed_abd")])
    conf_tax<-data.frame(conf[,c("exp_taxonomy_abd","observed_abd")])
    L2_seq<-with(conf_seq, L2(exp_sequence_abd,observed_abd))
    L2_tax<-with(conf_tax, L2(exp_taxonomy_abd,observed_abd))
    rJSD_seq<-with(conf_seq, rJSD(exp_sequence_abd,observed_abd))
    rJSD_tax<-with(conf_tax, rJSD(exp_taxonomy_abd,observed_abd))
    result<-list()
    result$L2_seq<-L2_seq
    result$L2_tax<-L2_tax
    result$rJSD_seq<-rJSD_seq
    result$rJSD_tax<-rJSD_tax
    result
  }
  abd_eval<-abd_metrics(conf)
  # p_res<-autoplot(sscurves) autoplot is not able to be output.
  result<-list()
  result$auprc_abd<-auc_res_abd[,4][2]
  result$auroc_abd<-auc_res_abd[,4][1]
  result$auprc_bi<-auc_res_bi[,4][2]
  result$auroc_bi<-auc_res_bi[,4][1]
  result$conf<-conf
  result$sscurves_abd<-sscurves_abd
  result$sscurves_bi<-sscurves_bi
  result$L2_seq<-abd_eval$L2_seq
  result$L2_tax<-abd_eval$L2_tax
  result$rJSD_seq<-abd_eval$rJSD_seq
  result$rJSD_tax<-abd_eval$rJSD_tax
  result
}


#' Performance comparisons: AUPR score and L2 distance
#'-------------------------------
#' **AUPR score**: 
#' 1. acutal abundance
#' 2. binary abundance
#' 
#' **L2 distance**: 
#' 1. sequence abundance
#' 2. taxonomic abundance


datasets<-c("simulate_10","simulate_20","simulate_50","simulate_200","simulate_500")
#datasets<-datasets[-1] #[-8:-length(datasets)] ### remove those datasets with no positives
perf_summ<-data.frame(matrix(NA, ncol=18, nrow=length(datasets)))
colnames(perf_summ)<-c("auprc_abd__Bracken", "auprc_abd__IIB", "auprc_abd__Metaphlan2", 
                       "auprc_bi__Bracken", "auprc_bi__IIB", "auprc_bi__Metaphlan2", 
                       "L2_tax__Bracken",  "L2_tax__IIB", "L2_tax__Metaphlan2",
                       "L2_seq__Bracken",  "L2_seq__IIB", "L2_seq__Metaphlan2",
                       "rJSD_tax__Bracken",  "rJSD_tax__IIB", "rJSD_tax__Metaphlan2",
                       "rJSD_seq__Bracken",  "rJSD_seq__IIB", "rJSD_seq__Metaphlan2") 
rownames(perf_summ)<-datasets
for(i in 1:length(datasets)){
  #exp_tab_list[[i]]$exp_sequence_abd<-exp_tab_list[[i]]$exp_sequence_abd*100
  #exp_tab_list[[i]]$exp_taxonomy_abd<-exp_tab_list[[i]]$exp_taxonomy_abd*100
  ## get auprc score
  bracken_res<-get.perf.from.tabs(expected_tab = exp_tab_list[[i]], observed_tab = bracken_list[[i]])
  IIb_res<-get.perf.from.tabs(expected_tab = exp_tab_list[[i]], observed_tab = IIb_list[[i]])
  mpa2_res<-get.perf.from.tabs(expected_tab = exp_tab_list[[i]], observed_tab = mpa2_list[[i]])
  perf_summ[i, 1]<-bracken_res$auprc_abd
  perf_summ[i, 2]<-IIb_res$auprc_abd
  perf_summ[i, 3]<-mpa2_res$auprc_abd
  perf_summ[i, 4]<-bracken_res$auprc_bi
  perf_summ[i, 5]<-IIb_res$auprc_bi
  perf_summ[i, 6]<-mpa2_res$auprc_bi
  perf_summ[i, 7]<-bracken_res$L2_tax
  perf_summ[i, 8]<-IIb_res$L2_tax
  perf_summ[i, 9]<-mpa2_res$L2_tax
  perf_summ[i, 10]<-bracken_res$L2_seq
  perf_summ[i, 11]<-IIb_res$L2_seq
  perf_summ[i, 12]<-mpa2_res$L2_seq
  perf_summ[i, 13]<-bracken_res$rJSD_tax
  perf_summ[i, 14]<-IIb_res$rJSD_tax
  perf_summ[i, 15]<-mpa2_res$rJSD_tax
  perf_summ[i, 16]<-bracken_res$rJSD_seq
  perf_summ[i, 17]<-IIb_res$rJSD_seq
  perf_summ[i, 18]<-mpa2_res$rJSD_seq
}

#' Benchmarking of all classifiers (i.e. IIB, Bracken and Metaphlan2)
#' -------------------------------
perf_summ$datasize<-c(10, 20, 50, 200, 500)
perf_summ_m<-melt(perf_summ, id.vars = c("datasize"))
temp<-data.frame(do.call(rbind, strsplit(as.character(perf_summ_m$variable), "__")))
names(temp)<-c("metric", "profiler")
perf_summ_m<-data.frame(temp, perf_summ_m)
auprc_summ_m<-perf_summ_m[grep("auprc", perf_summ_m$metric), ]
p<-ggplot(auprc_summ_m, aes(x=profiler, y=value)) + geom_boxplot(outlier.shape = NA) + 
  ylab("AUPR score")+
  geom_jitter(aes(color=datasize), width = 0.2) + 
  facet_wrap(~metric) + 
  theme_bw()
p
ggsave(filename="./NewSim_auprc_3_boxplot.pdf", plot=p, width =5 , height=4)

abd_eval_summ_m<-perf_summ_m[grep(paste(c("L2", "rJSD"), collapse="|"), perf_summ_m$metric), ]
L2_summ_m<-subset(perf_summ_m, metric=="L2_tax" | metric=="L2_seq")
p<-ggplot(abd_eval_summ_m, aes(x=profiler, y=value)) + geom_boxplot(outlier.shape = NA) + 
  ylab("L2 distance")+
  geom_jitter(aes(color=datasize), width = 0.2) + 
  facet_wrap(~metric, scales="free_y") + 
  theme_bw()
p
ggsave(filename="./NewSim_L2.dist_3_boxplot.pdf", plot=p, width =5 , height=4)

#' Benchmarking of only Bracken and Metaphlan2
#' -------------------------------
auprc_2_summ_m<-subset(auprc_summ_m, profiler!="IIB")
p<-ggplot(auprc_2_summ_m, aes(x=profiler, y=value)) + geom_boxplot(outlier.shape = NA) + 
  ylab("AUPR score")+
  geom_jitter(aes(color=datasize), width = 0.2) + 
  facet_wrap(~metric) + 
  theme_bw()
p
ggsave(filename="./NewSim_auprc_bracken-metaplhan2_boxplot.pdf", plot=p, width =5 , height=4) 
ggsave(filename="./NewSim_auprc_bracken-metaplhan2_boxplot.png", plot=p, device="png", width =5 , height=4) 
L2_2_summ_m<-subset(L2_summ_m, profiler!="IIB")
p<-ggplot(L2_2_summ_m, aes(x=profiler, y=value)) + geom_boxplot(outlier.shape = NA) + 
  ylab("L2 distance")+
  geom_jitter(aes(color=datasize), width = 0.2) + 
  facet_wrap(~metric) + 
  theme_bw()
p
ggsave(filename="./NewSim_L2.dist_bracken-metaplhan2_boxplot.pdf", plot=p, width =5 , height=4)
ggsave(filename="./NewSim_L2.dist_bracken-metaplhan2_boxplot.png", plot=p, device="png", width =5 , height=4) 

