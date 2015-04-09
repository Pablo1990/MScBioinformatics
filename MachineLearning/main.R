library("AgiMicroRna")
library("genefilter")
library("ArrayTools")

targets <- readTargets("datasets/GSE43696_RAW/targets.txt")

dataFiles <- list.files("datasets/GSE43696_RAW/", pattern = "[0-9]+")

data <- readMicroRnaAFE(targets,verbose = T)
