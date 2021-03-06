normalizeData <- function(directoryName) {
  #Do it with just one directory from one gse, with all, will blow up
  dataFiles <- list.celfiles(path=directoryName, full.names=TRUE, recursive=TRUE)
  
  #From Rma
  "data <- c()
  for(dataFile in dataFiles) {
  data <- c(data,just.rma(dataFile))
  }"
  
  #From Affy
  data <- ReadAffy(filenames=dataFiles)
  
  #4. Normalizar con RMA 
  #se crea el objeto eset de clase ExprSet, 
  #la funcion expresso devuelve los datos de intensidad con transformacion log
  eset <- expresso(data,
                   bg.correct = TRUE, 
                   bgcorrect.method="rma",
                   normalize = TRUE, 
                   normalize.method="quantiles", 
                   pmcorrect.method="pmonly", 
                   summary.method="medianpolish",
                   verbose = TRUE,
  ) 
  
  
  #5. Generar BOXPLOTS antes y despues de normalizar
  
  #boxplot de datos brutos
  boxplot(data,
          main="Boxplot Before Normalization",
          col = "lightgrey")
  
  
  #boxplot de datos normalizados  	
  exprseset <- as.data.frame(exprs(eset))		
  boxplot(data.frame(exprseset),
          main="Boxplot After Normalization (log scale)",
          col = "white")
  
  
  #6.Filtrar los datos por IQR.
  esetIQR <- varFilter(eset, var.func=IQR, var.cutoff=0.5, filterByQuantile=TRUE) 
  
  return (esetIQR)
}