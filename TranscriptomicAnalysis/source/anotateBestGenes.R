anotateBestGenes <- function(){
  library("hgu95av2.db")
  
  data18198ALL.best<-subset(data18198ALL, dataDiff18198ALL$adj.P.Val<=0.05)
  probenames.fdr.005<-as.character(rownames(data18198ALL.best))
  
  library("annotate")
  GeneSymbol2.fdr.005<-getSYMBOL(probenames.fdr.005,"hgu95av2.db")
}