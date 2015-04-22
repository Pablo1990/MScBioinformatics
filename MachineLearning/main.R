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

#--------------------------

targetsGSE63142 <- readTargets("datasets/GSE63142_RAW/targets.txt", row.names="FileName")

dataFilesGSE63142 <- list.files("datasets/GSE63142_RAW/", pattern = "[0-9]+")

setwd("~/MScBioinformatics/MachineLearning/datasets/GSE63142_RAW")

dataGSE63142 <- read.maimages(targetsGSE63142, source="agilent",verbose = T, green.only = T)

setwd("~/MScBioinformatics/MachineLearning/")

dataNormalizedGSE63142 <- backgroundCorrect(dataGSE63142, method="normexp")

#ENorm <- normalizeBetweenArrays(data, method="quantile")

attributesStrGSE63142 <- "@RELATION asthma\n"

for (att in 1:length(row.names(dataNormalizedGSE63142$genes))){
  if(!dataNormalizedGSE63142$genes$ControlType[att]){
    attributesStrGSE63142 <- paste(c(attributesStrGSE63142,paste(c('@ATTRIBUTE', dataNormalizedGSE63142$genes$ProbeName[att] , 'REAL'), collapse = ' ')), collapse='\n')
  }
}
attributesStrGSE63142 <- paste(c(attributesStrGSE63142, '@ATTRIBUTE class {Control, MMA, SA}'))

#Filter the control genes
dataNormalizedFGSE63142 <- dataNormalizedGSE63142$E[as.integer(row.names(dataNormalizedGSE63142$genes[dataNormalizedGSE63142$genes$ControlType==0,])),]

dataNormalizedTGSE63142 <- t(dataNormalizedFGSE63142)

dataStrGSE63142 <- "@DATA"

for (d in 1:length(row.names(dataNormalizedTGSE63142))){
  dataStrGSE63142 <- paste(c(dataStrGSE63142, paste(c(dataNormalizedTGSE63142[d,],dataNormalizedGSE63142$targets$Classes[d]), collapse=',')), collapse='\n')
}

fileConn<-file("GSE63142.arff")
writeLines(paste(c(attributesStrGSE63142, dataStrGSE63142), collapse='\n'), fileConn)
close(fileConn)
  
