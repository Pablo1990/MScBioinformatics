source("http://bioconductor.org/biocLite.R")
library("affy")

#You can find this data in http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE18198
"multiline
comment
"
dataFiles <- list.files(path="./data", full.names=TRUE, recursive=TRUE)
data <- c()
dataFiles[1]
file <- as.character(dataFiles[1])
justRMA(filename=dataFiles[1])
for(dataFile in dataFiles) {
  data <- c(data,justRMA(dataFile))
}

