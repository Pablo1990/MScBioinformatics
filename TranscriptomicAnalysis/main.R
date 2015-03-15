#source("http://bioconductor.org/biocLite.R")
#biocLite("ArrayTools")

library("affy")
library("limma")
library("genefilter")
library("ArrayTools")

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

data18198 <- normalizeData(fileDirs[2])

dataDiff18198 <- differentialExpression(targets[cont], data18198, design18198, cont.matrix18198)

setwd("~/MScBioinformatics/TranscriptomicAnalysis/data/RawData/GSE18198_RAW/")

createGSEAFiles(eSet = data18198[rownames(dataDiff18198)], catVar="sample")

setwd("~/MScBioinformatics/TranscriptomicAnalysis")

#output.gct(normal, filename = "probe")

# Caso 18351 --------------------------------------------------------------

design18351 <- cbind(Control=c(1,1,1,0,0,0), Cases=c(0,0,0,1,1,1))

rownames(design18351) <- targets[2]$FileName

cont.matrix18351 <- makeContrasts(CasesvsControl=Cases-Control,levels=design18351) 

data18351 <- normalizeData(fileDirs[3])

#Volver a comprobar esta expresión diferencial con babelomics, geneToR, asterias...
dataDiff18351 <- differentialExpression(targets[cont], data18351, design18351, cont.matrix18351)

#Probar esto
#design = cbind(mean=1,diff=cl)  		##generamos la matriz de diseño
#fit = lmFit(exprs(ALL),design)			##ajustamos el modelo lineal con los datos de ALL segun matriz de diseño
#fit2 = eBayes(fit)						##test bayesiano sobre el modelo lineal ajustado
#res<-topTable(fit2, coef="diff", adjust.method = "fdr", sort.by="p")  ##salida de resultados

#data18351[rownames(dataDiff18351)]

setwd("~/MScBioinformatics/TranscriptomicAnalysis/data/RawData/GSE18351_RAW/")

createGSEAFiles(eSet = data18351[rownames(dataDiff18351)], catVar="sample")

setwd("~/MScBioinformatics/TranscriptomicAnalysis")
