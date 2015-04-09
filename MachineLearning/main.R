library("limma")
library("genefilter")
library("ArrayTools")
library("RWeka")

targets <- readTargets("datasets/GSE43696_RAW/targets.txt", row.names="FileName")

dataFiles <- list.files("datasets/GSE43696_RAW/", pattern = "[0-9]+")

setwd("~/MScBioinformatics/MachineLearning/datasets/GSE43696_RAW")

data <- read.maimagess(targets, source="agilent",verbose = T, green.only = T)

setwd("~/MScBioinformatics/MachineLearning/")

dataNormalized <- backgroundCorrect(data,method="normexp")



write.arff(dataNormalized,file = "culo.arff")
