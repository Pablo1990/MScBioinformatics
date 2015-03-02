#source("http://bioconductor.org/biocLite.R")

library("affy")
library("limma")
library("genefilter")

source("source/differentialExpression.R")
source("source/normalizeData.R")

#You can find this data in http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE18198


fileDirs <- list.dirs(path = './data/RawData')

targets18198 <- readTargets("./data/RawData/GSE18198_RAW/targets.txt", row.names="FileName") 
targets18351 <- readTargets("./data/RawData/GSE18351_RAW/targets.txt", row.names="FileName")

#change this to see what we are looking for
design <-list(cbind(Control=c(1,1,1,1,1,1,0,0,0,0,0,0), Cases=c(0,0,0,0,0,0,1,1,1,1,1,1)))
#design18198<-cbind(Control=c(1,1,1,0,0,0,1,1,1,0,0,0), Cases=c(0,0,0,1,1,1,0,0,0,1,1,1))

design<-list(design, cbind(Control=c(1,1,1,0,0,0), Cases=c(0,0,0,1,1,1)))

data <- c()
dataDiff <- c()
cont <- 1
for (dir in fileDirs[-1]) {
  aux <- normalizeData(dir)
  data <- c(data, aux)
  dataDiff <- c(dataDiff, aux, design[cont])
  cont <- 2
}
