library("limma")
library("genefilter")
library("ArrayTools")

targets <- readTargets("datasets/GSE43696_RAW/targets.txt", row.names="FileName")

dataFiles <- list.files("datasets/GSE43696_RAW/", pattern = "[0-9]+")

data <- read.maimages(targets, source="agilent",verbose = T, green.only = T)

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