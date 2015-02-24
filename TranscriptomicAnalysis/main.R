source("http://bioconductor.org/biocLite.R")
library("affy")

#You can find this data in http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE18198
"multiline
comment
"
dataFiles <- list.files(path="./data", full.names=TRUE, recursive=TRUE)
data <- c()
for(dataFile in dataFiles) {
  data <- c(data,just.rma(dataFile))
}

