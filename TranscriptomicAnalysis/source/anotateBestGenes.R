anotateBestGenes <- function(){
  library("hgu133plus2.db")
  library("annotate")
  
  data18198ALL.best<-subset(data18198ALL, dataDiff18198ALL$adj.P.Val<=0.01)
  probenames.fdr.005<-as.character(rownames(data18198ALL.best))
  
  
  GeneSymbol2.fdr.005<-getSYMBOL(probenames.fdr.005,"hgu133plus2.db")
  
  finalGenes <- GeneSymbol2.fdr.005[!is.na(GeneSymbol2.fdr.005)]
  
  #now scrapping to look for the genes with annotation?
  
  #list.GeneSymbol.fdr.005<-mget(probenames.fdr.005, hgu133plus2SYMBOL)
  #char.GeneSymbol.fdr.005<- as.character(list.GeneSymbol.fdr.005)
}