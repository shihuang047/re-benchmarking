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
IIb_output_file="./NewSimDatasets_Results/IIB/010.IIB.xls"
IIb_transformer<-function(IIb_output_file){
  IIb_output<-read.csv(IIb_output_file, sep="\t", header=TRUE, skip=1)
  IIb_output<-subset(IIb_output, IIb_output$G_Score>20)
  IIb_output[, "Sequenced_Reads_Num.Theoretical_Tag_Num"]<-100*(IIb_output[, "Sequenced_Reads_Num.Theoretical_Tag_Num"]/sum(IIb_output[, "Sequenced_Reads_Num.Theoretical_Tag_Num"]))
  observed_tab<-IIb_output[, c("Specie", "Sequenced_Reads_Num.Theoretical_Tag_Num")]
  colnames(observed_tab)<-c("taxID", "observed_abd")
  observed_tab$observed_abd<-observed_tab$observed_abd/100
  observed_tab
}
#IIb_transformer(IIb_output_file)
IIb_output_files<-list.files("IIB.xls", path = "./NewSimDatasets_Results/IIB/",full.names = T)
IIb_list<-lapply(IIb_output_files, IIb_transformer)

#'bracken_transformer
bracken_output_file="./NewSimDatasets_Results/bracken/simulate_500_6M_bracken.kreport"
bracken_transformer<-function(bracken_output_file, RANK="S"){
  braken_columns = c('observed_abd', 'lca_read_count', 'read_count', 'rank',
                    'taxID', 'taxname')
  bracken_output<-read.csv(bracken_output_file, sep="\t", header=F)
  colnames(bracken_output)<-braken_columns
  observed_tab<-subset(bracken_output, rank==RANK)[, c("taxID", "observed_abd")]
  observed_tab$observed_abd<-observed_tab$observed_abd/100
  observed_tab
}
bracken_output_files<-list.files("bracken.kreport", path = "NewSimDatasets_Results/bracken", full.names = T)
bracken_list<-lapply(bracken_output_files, bracken_transformer)

#'PathSeq_transformer
#PathSeq_output_file="./NewSimDatasets_Results/PathSeq/scores_simulate_500_20M.txt"
PathSeq_output_file="./NewSimDatasets_Results/PathSeq/scores_simulate_020.txt"
PathSeq_transformer<-function(PathSeq_output_file, RANK="species"){
  PathSeq_output<-read.csv(PathSeq_output_file, sep="\t", header=T, comment.char = "")
  colnames(PathSeq_output)[6]<-"observed_abd"
  colnames(PathSeq_output)[1]<-"taxID"
  observed_tab<-subset(PathSeq_output, type==RANK)[, c("taxID", "observed_abd")]
  observed_tab$observed_abd<-observed_tab$observed_abd/sum(observed_tab$observed_abd)
  observed_tab
}
PathSeq_output_files<-list.files("scores_", path = "NewSimDatasets_Results/PathSeq", full.names = T)
PathSeq_list<-lapply(PathSeq_output_files, PathSeq_transformer)


#'mpa2_transformer
mpa2_output_file="./NewSimDatasets_Results/mpa2/simulate_010_mpa2.txt"
mpa2_taxname_dic_file<-"./SimDatasets5_truth_results/mpa2_taxname_dic.txt"
mpa2_transformer<-function(mpa2_output_file){
  #mpa2_taxname_dic<-read.table(mpa2_taxname_dic_file, sep="\t", header=TRUE)
  #mpa2_taxname_dic2<-mpa2_taxname_dic[, c("mpa2_name", "taxid")]
  #na_idx<-which(is.na(mpa2_taxname_dic2$mpa2_name))
  #mpa2_taxname_dic2$mpa2_name[is.na(mpa2_taxname_dic2$mpa2_name)]<-"NA" #paste("NA", seq_along(1:length(na_idx)), sep = "")
  mpa2_output<-read.csv(mpa2_output_file, sep="\t", header=TRUE, comment.char = "")
  #mpa2_output<-merge(mpa2_taxname_dic2, mpa2_output, by=c(1, 1), all.y=T)
  colnames(mpa2_output)<-c("taxID", "taxname", "observed_abd")
  observed_tab<-mpa2_output
  observed_tab$observed_abd<-observed_tab$observed_abd/100
  observed_tab
}
#mpa2_transformer(mpa2_output_file)
mpa2_output_files<-list.files("mpa2.txt", path = "./NewSimDatasets_Results/mpa2", full.names = T)
mpa2_list<-lapply(mpa2_output_files, mpa2_transformer)

#'mOTUs_transformer
mOTUs_output_file="./NewSimDatasets_Results/mOTUs/motus_010_edit.txt"
mOTUs_transformer<-function(mOTUs_output_file){
  mOTUs_output<-read.csv(mOTUs_output_file, sep="\t", header=TRUE, comment.char = "")
  colnames(mOTUs_output)<-c("taxID", "taxname", "observed_abd")
  observed_tab<-mOTUs_output
  #observed_tab$observed_abd<-observed_tab$observed_abd/100
  observed_tab
}
#mpa2_transformer(mpa2_output_file)
mOTUs_output_files<-list.files("motus", path = "./NewSimDatasets_Results/mOTUs", full.names = T)
mOTUs_list<-lapply(mOTUs_output_files, mOTUs_transformer)

#'Diamond_transformer
Diamond_output_file="./NewSimDatasets_Results/Diamond/diamond_010_awk_edit.txt"
Diamond_transformer<-function(Diamond_output_file){
  Diamond_output<-read.csv(Diamond_output_file, sep="\t", header=TRUE, comment.char = "")
  colnames(Diamond_output)<-c("taxID", "observed_abd", "observed_abd_all")
  observed_tab<-Diamond_output
  #observed_tab$observed_abd<-observed_tab$observed_abd/100
  observed_tab
}
Diamond_output_files<-list.files("diamond", path = "./NewSimDatasets_Results/Diamond", full.names = T)
Diamond_list<-lapply(Diamond_output_files, Diamond_transformer)


#'Kaiju_transformer
Kaiju_output_file="./NewSimDatasets_Results/Kaiju/kaiju_010_awk_edit.txt"
Kaiju_transformer<-function(Kaiju_output_file){
  Kaiju_output<-read.csv(Kaiju_output_file, sep="\t", header=TRUE, comment.char = "")
  colnames(Kaiju_output)<-c("taxID", "observed_abd", "observed_abd_all")
  observed_tab<-Kaiju_output
  #observed_tab$observed_abd<-observed_tab$observed_abd/100
  observed_tab
}
Kaiju_output_files<-list.files("kaiju", path = "./NewSimDatasets_Results/Kaiju", full.names = T)
Kaiju_list<-lapply(Kaiju_output_files, Kaiju_transformer)


#' Expected abundance data input from xlsx
#'-------------------------------
exp_xlsx_file="NewSimDatasets_Groundtruth.xlsx" ##"NewSimDatasets_Groundtruth_summ_11222019.xlsx"
sheets<-excel_sheets(exp_xlsx_file)
#sheets<-sheets[-1]
exp_list<-list()
for(i in 1:length(sheets)){
  exp_list[[i]]<-data.frame(read_xlsx(exp_xlsx_file, sheet=sheets[i]))
}
exp_transformer<-function(exp_file){
  # exp<-read.table(exp_file, sep="\t", header=F)
  exp<-exp_file[, c("taxid", "taxonomy_abd", "sequence_abd")]
  colnames(exp)<-c("taxID", "exp_taxonomy_abd", "exp_sequence_abd")
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
  # ID metrics
  sscurves_bi_seq <- evalmod(scores = conf$bi_observed_abd, labels = conf$bi_exp_sequence_abd, na_worst = TRUE)
  sscurves_abd_seq <- evalmod(scores = conf$observed_abd, labels = conf$bi_exp_sequence_abd, na_worst = TRUE)
  sscurves_bi_tax <- evalmod(scores = conf$bi_observed_abd, labels = conf$bi_exp_taxonomy_abd, na_worst = TRUE)
  sscurves_abd_tax <- evalmod(scores = conf$observed_abd, labels = conf$bi_exp_taxonomy_abd, na_worst = TRUE)
  #sscurves_abd_all <- evalmod(scores = conf$observed_abd, labels = conf$sequence_abd)
  auc_res_bi_seq<-auc(sscurves_bi_seq); auprc_bi_seq<-auc_res_bi_seq[,4][2]
  auc_res_abd_seq<-auc(sscurves_abd_seq); auprc_abd_seq<-auc_res_abd_seq[,4][2]
  auc_res_bi_tax<-auc(sscurves_bi_tax); auprc_bi_tax<-auc_res_bi_tax[,4][2]
  auc_res_abd_tax<-auc(sscurves_abd_tax); auprc_abd_tax<-auc_res_abd_tax[,4][2]
  library(caret)
  #precision(as.factor(conf$bi_observed_abd), as.factor(conf$bi_exp_taxonomy_abd))
  #precision <- caret::posPredValue(factor(conf$bi_observed_abd), factor(conf$bi_exp_sequence_abd), positive="1")
  #recall <- caret::sensitivity(factor(conf$bi_observed_abd), factor(conf$bi_exp_sequence_abd), positive="1")
  #F1 <- (2 * precision * recall) / (precision + recall)
  f1_score <- function(predicted, expected, positive.class="1") {
    predicted <- factor(as.character(predicted), levels=unique(as.character(expected)))
    expected  <- as.factor(expected)
    cm = as.matrix(table(expected, predicted))
    
    precision <- diag(cm) / colSums(cm)
    recall <- diag(cm) / rowSums(cm)
    f1 <-  ifelse(precision + recall == 0, 0, 2 * precision * recall / (precision + recall))
    
    #Assuming that F1 is zero when it's not possible compute it
    f1[is.na(f1)] <- 0
    
    #Binary F1 or Multi-class macro-averaged F1
    F1<-ifelse(nlevels(expected) == 2, f1[positive.class], mean(f1))
    result<-list()
    result$precision<-precision
    result$recall<-recall
    result$F1<-F1
    result
  }
  F1_seq<-f1_score(conf$bi_observed_abd, conf$bi_exp_sequence_abd, positive.class = "1")$F1
  F1_tax<-f1_score(conf$bi_observed_abd, conf$bi_exp_taxonomy_abd, positive.class = "1")$F1
  # abundance-estimation metrics
  L2<-function(x, y){
    d<-x-y
    sqrt(sum(d^2, na.rm=T))
  }
  rJSD <- function(x, y){
    if(any(x>1, na.rm=T) && any(y>1, na.rm=T)) {x<-x/100; y<-y/100}
    m <- 0.5 * (x + y) 
    out<- sqrt(0.5 * sum(x * (log(x) -log(m)), na.rm=T) + 0.5* sum(y * (log(y) - log(m)), na.rm=T))
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
  result$auprc_abd_seq<-auprc_abd_seq
  #result$auroc_abd_seq<-auroc_abd_seq
  result$auprc_bi_seq<-auprc_bi_seq
  #result$auroc_bi_seq<-auroc_bi_seq
  result$auprc_abd_tax<-auprc_abd_tax
  #result$auroc_abd_tax<-auroc_abd_tax
  result$auprc_bi_tax<-auprc_bi_tax
  #result$auroc_bi_tax<-auroc_bi_tax
  result$F1_seq<-F1_seq
  result$F1_tax<-F1_tax
  result$conf<-conf
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


datasets<-c("simulate_10","simulate_20","simulate_50","simulate_200","simulate_500_200M", "simulate_500_6M")
metric_names<-c("auprc_abd_seq", "auprc_bi_seq", "auprc_abd_tax", "auprc_bi_tax", "F1_seq", "F1_tax","L2_seq", "L2_tax", "rJSD_seq", "rJSD_tax")
method_names<-c("bracken", "PathSeq", "mpa2", "mOTUs", "Diamond", "Kaiju") #
method_class<-c("DNA-to-DNA_method", "DNA-to-DNA_method", "Marker-based_method", "Marker-based_method", "DNA-to-protein_method", "DNA-to-protein_method")
method_names<-paste(method_names, method_class, sep = "__")
perf_summ<-data.frame(matrix(NA, ncol=length(metric_names)*length(method_names), nrow=length(datasets)))
colnames(perf_summ)<-as.vector(outer(metric_names, method_names, paste, sep="__"))
rownames(perf_summ)<-datasets
for(i in 1:length(datasets)){
  #exp_tab_list[[i]]$exp_sequence_abd<-exp_tab_list[[i]]$exp_sequence_abd*100
  #exp_tab_list[[i]]$exp_taxonomy_abd<-exp_tab_list[[i]]$exp_taxonomy_abd*100
  #IIb_res<-get.perf.from.tabs(expected_tab = exp_tab_list[[i]], observed_tab = IIb_list[[i]])
  bracken_res<-get.perf.from.tabs(expected_tab = exp_tab_list[[i]], observed_tab = bracken_list[[i]])
  PathSeq_res<-get.perf.from.tabs(expected_tab = exp_tab_list[[i]], observed_tab = PathSeq_list[[i]])
  mpa2_res<-get.perf.from.tabs(expected_tab = exp_tab_list[[i]], observed_tab = mpa2_list[[i]])
  mOTUs_res<-get.perf.from.tabs(expected_tab = exp_tab_list[[i]], observed_tab = mOTUs_list[[i]])
  Diamond_res<-get.perf.from.tabs(expected_tab = exp_tab_list[[i]], observed_tab = Diamond_list[[i]])
  Kaiju_res<-get.perf.from.tabs(expected_tab = exp_tab_list[[i]], observed_tab = Kaiju_list[[i]])
  #perf_summ[i, 13:16]<-unlist(IIb_res[c(1, 3, 8:11)])
  perf_summ[i, 1:10]<-unlist(bracken_res[c(1:6, 8:11)])
  perf_summ[i, 11:20]<-unlist(PathSeq_res[c(1:6, 8:11)])
  perf_summ[i, 21:30]<-unlist(mpa2_res[c(1:6, 8:11)])
  perf_summ[i, 31:40]<-unlist(mOTUs_res[c(1:6, 8:11)])
  perf_summ[i, 41:50]<-unlist(Diamond_res[c(1:6, 8:11)])
  perf_summ[i, 51:60]<-unlist(Kaiju_res[c(1:6, 8:11)])
}

#' Benchmarking of all classifiers (i.e. IIB, Bracken and Metaphlan2)
#' -------------------------------
perf_summ$datasize<-c(10, 20, 50, 200, 500, 500)
perf_summ_m<-melt(perf_summ, id.vars = c("datasize"))
temp<-data.frame(do.call(rbind, strsplit(as.character(perf_summ_m$variable), "__")))
names(temp)<-c("metric", "profiler", "method_class")
perf_summ_m<-data.frame(temp, perf_summ_m)
perf_summ_m$profiler<-factor(perf_summ_m$profiler, levels = c("bracken", "PathSeq", "mpa2", "mOTUs", "Diamond", "Kaiju"), ordered = TRUE)
ID_summ_m<-perf_summ_m[c(grep("auprc", perf_summ_m$metric), grep("F1", perf_summ_m$metric)), ]
p<-ggplot(ID_summ_m, aes(x=profiler, y=value)) + 
  geom_boxplot(aes(fill=method_class), alpha=.5, outlier.shape = NA) + 
  ylab("AUPR score")+
  geom_jitter(aes(color=datasize), width = 0.2) + 
  facet_wrap(~metric, ncol=2) + 
  theme_bw()  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
p
ggsave(filename="./NewSim_ID_eval_boxplot.pdf", plot=p, width =5 , height=6)
ggsave(filename="./NewSim_ID_eval_boxplot.png", plot=p, device="png", width =5 , height=6)

abd_eval_summ_m<-perf_summ_m[grep(paste(c("L2", "rJSD"), collapse="|"), perf_summ_m$metric), ]
L2_summ_m<-subset(perf_summ_m, metric=="L2_tax" | metric=="L2_seq")
p<-ggplot(abd_eval_summ_m, aes(x=profiler, y=value)) + 
  geom_boxplot(aes(fill=method_class), alpha=0.5, outlier.shape = NA) + 
  ylab("Distance to the expected")+
  geom_jitter(aes(color=datasize), width = 0.2) + 
  facet_wrap(~metric, scales="free_y") + 
  theme_bw()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
p
ggsave(filename="./NewSim_abd_eval_boxplot.pdf", plot=p, width =8 , height=6)
ggsave(filename="./NewSim_abd_eval_boxplot.png", plot=p, device = "png",  width =8 , height=6)

