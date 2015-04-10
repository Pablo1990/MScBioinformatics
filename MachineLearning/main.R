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

#write.csv(dataNormalized$E, "aux.csv")

#attributes <- colnames(dataNormalized$E)

attributesStr <- "@RELATION asthma\n"

for (att in 1:length(row.names(dataNormalized$genes))){
  if(!dataNormalized$genes$ControlType[att])
    attributesStr <- paste(c(attributesStr,paste(c('@ATTRIBUTE', dataNormalized$genes$ProbeName[att] , 'numeric'), collapse = ' ')), collapse='\n')
}

attributesStr <- paste(c(attributesStr, '@ATTRIBUTE class\t{mma, sa}'))



fileConn<-file("final.arff")
writeLines(attributesStr, fileConn)
close(fileConn)




#tableData <- read.csv("aux.csv")

#write.arff(dataNormalized$E ,file = "aux.arff")
