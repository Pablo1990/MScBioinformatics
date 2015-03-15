#######Differential expression analysis.#######
differentialExpression <- function(targets, esetIQR, design, cont.matrix){
  
  #9. Obtener genes diferencialmente expresados 
  #Modelo lineal y eBayes 
  fit<-lmFit(esetIQR,design)  ##getting DEGs from IQR 
  fit2<-contrasts.fit(fit, cont.matrix)
  fit2<-eBayes(fit2)
  
  #Lista de genes diferencialmente expresados (topTable por defecto da los 10 mejores segun pvalor, ajustar number para obtener todos los genes)
  #toptableIQR<-topTable(fit2, number=dim(exprs(esetIQR))[1], adjust.method="BH", sort.by="p")
  toptableIQR<-topTable(fit2, number=100, adjust.method="BH", sort.by="p")
  
  return (toptableIQR)
}