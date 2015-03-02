#source("http://bioconductor.org/biocLite.R")

library("affy")
library("limma")
library("genefilter")

source("source/differentialExpression.R")
source("source/normalizeData.R")

#You can find this data in http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE18198


fileDirs <- list.dirs(path = './data/RawData')

targets <- list(readTargets("./data/RawData/GSE18198_RAW/targets.txt", row.names="FileName"))
targets <- list(targets, readTargets("./data/RawData/GSE18351_RAW/targets.txt", row.names="FileName"))


# Caso 18198 --------------------------------------------------------------

#change this to see what we are looking for
design18198 <-cbind(Control=c(1,1,1,1,1,1,0,0,0,0,0,0), Cases=c(0,0,0,0,0,0,1,1,1,1,1,1))
#design18198<-cbind(Control=c(1,1,1,0,0,0,1,1,1,0,0,0), Cases=c(0,0,0,1,1,1,0,0,0,1,1,1))

rownames(design18198)<-targets[1]$FileName

cont.matrix18198 <- makeContrasts(CasesvsControl=Cases-Control,levels=design18198)

data18198 <- normalizeData(dir[1])

dataDiff18198 <- differentialExpression(targets[cont], data18198, design18198)


# Caso 18351 --------------------------------------------------------------

design18351 <-list(design, cbind(Control=c(1,1,1,0,0,0), Cases=c(0,0,0,1,1,1)))



rownames(design18351)<-targets[1]$FileName

cont.matrix<-makeContrasts(CasesvsControl=Cases-Control,levels=design18351) 

data18351 <- normalizeData(dir[1])

dataDiff18351 <- differentialExpression(targets[cont], data18351, design18351)


