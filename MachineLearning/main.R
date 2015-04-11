library("limma")
library("genefilter")
library("ArrayTools")
library("RWeka")

targets <- readTargets("datasets/GSE43696_RAW/targets.txt", row.names="FileName")

dataFiles <- list.files("datasets/GSE43696_RAW/", pattern = "[0-9]+")

#setwd("~/MScBioinformatics/MachineLearning/datasets/GSE43696_RAW")

data <- read.maimages(targets, source="agilent",verbose = T, green.only = T)

setwd("~/MScBioinformatics/MachineLearning/")

dataNormalized <- backgroundCorrect(data, method="normexp")

#ENorm <- normalizeBetweenArrays(data, method="quantile")

attributesStr <- "@RELATION asthma\n"

for (att in 1:length(row.names(dataNormalized$genes))){
  if(!dataNormalized$genes$ControlType[att]){
    attributesStr <- paste(c(attributesStr,paste(c('@ATTRIBUTE', dataNormalized$genes$ProbeName[att] , 'REAL'), collapse = ' ')), collapse='\n')
  }
}
attributesStr <- paste(c(attributesStr, '@ATTRIBUTE class {Control, MMA, SA}'))

#Filter the control genes
dataNormalizedF <- dataNormalized$E[as.integer(row.names(dataNormalized$genes[dataNormalized$genes$ControlType==0,])),]

dataNormalizedT <- t(dataNormalizedF)

dataStr <- "@DATA"

for (d in 1:length(row.names(dataNormalizedT))){
    dataStr <- paste(c(dataStr, paste(c(dataNormalizedT[d,],dataNormalized$targets$Classes[d]), collapse=',')), collapse='\n')
}

fileConn<-file("final.arff")
writeLines(paste(c(attributesStr, dataStr), collapse='\n'), fileConn)
close(fileConn)
