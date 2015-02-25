source("http://bioconductor.org/biocLite.R")
library("affy")

#You can find this data in http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE18198
"multiline
comment
"
#Do it with just one directory from one gse, with all, will blow up
dataFiles <- list.celfiles(path="./data/RawData/GSE18198_RAW", full.names=TRUE, recursive=TRUE)

#From Rma
"data <- c()
for(dataFile in dataFiles) {
  data <- c(data,just.rma(dataFile))
}"

#From Affy
data <- ReadAffy(filenames=dataFiles)

eset <- expresso(data,
                 bg.correct = TRUE, 
                 bgcorrect.method="rma",
                 normalize = TRUE, 
                 normalize.method="quantiles", 
                 pmcorrect.method="pmonly", 
                 summary.method="medianpolish",
                 verbose = TRUE,
) 

