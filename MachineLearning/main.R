library("limma")
library("genefilter")
library("ArrayTools")
library("RWeka")

targets <- readTargets("datasets/GSE43696_RAW/targets.txt", row.names="FileName")

dataFiles <- list.files("datasets/GSE43696_RAW/", pattern = "[0-9]+")

setwd("~/MScBioinformatics/MachineLearning/datasets/GSE43696_RAW")

data <- read.maimages(targets, source="agilent",verbose = T, green.only = T)

setwd("~/MScBioinformatics/MachineLearning/")

dataNormalized <- backgroundCorrect(data, method="normexp")

#ENorm <- normalizeBetweenArrays(data, method="quantile")

write.csv(dataNormalized$E, "aux.csv")

attributes <- colnames(dataNormalized$E)

attributesStr <- "@RELATION asthma\n"

for (att in attributes){
  attributesStr <- paste(c(attributesStr,paste(c('@ATTRIBUTE', att, 'numeric'), collapse = ' ')), collapse='\n')
}

fileConn<-file("final.arff")
writeLines(attributesStr, fileConn)
close(fileConn)

for (dato in dataNormalized$E){
  
}



#tableData <- read.csv("aux.csv")

#write.arff(dataNormalized$E ,file = "aux.arff")
