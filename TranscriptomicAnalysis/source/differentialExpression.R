#######Differential expression analysis.#######
differentialExpression <- function(targets, esetIQR, design){
  #7. Matriz de diseño.
  rownames(design)<-targets$FileName
  #8. Matriz de contraste.
  cont.matrix<-makeContrasts(CasesvsControl=Cases-Control,levels=design) 
  
  
  #9. Obtener genes diferencialmente expresados 
  #Modelo lineal y eBayes 
  fit<-lmFit(esetIQR,design)  ##getting DEGs from IQR 
  fit2<-contrasts.fit(fit, cont.matrix)
  fit2<-eBayes(fit2)
  
  #Lista de genes diferencialmente expresados (topTable por defecto da los 10 mejores segun pvalor, ajustar number para obtener todos los genes)
  toptableIQR<-topTable(fit2, number=dim(exprs(esetIQR))[1], adjust.method="BH", sort.by="p")
  
  return (toptableIQR)
}