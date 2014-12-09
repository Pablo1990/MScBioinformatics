hi <- read.table("Additional_files_R-bioinfo-intro/hit-table-500-text.txt")
head(hi)
str(hi)
hist(hit[, 5])
hist(hi[, 5])
plot (hi[,13]~hi[, 3])

par(mfrow = c(1,2))
hist(hi[,5], breaks=50, xlab="", main="Alignment length")
plot(hi[,13]~hi[,3], xlab="Percent. identity", ylab="Bit sore")

#dev.off() #blow up the graphics

rnorm(5)
set.seed(12) #the seed of the random
rnorm(5)

set.seed(round(runif(1)))
set.seed(889898)

GeneA <- rnorm(50)
round(GeneA, 3)
(Type <- factor(c(rep("Colon", 30), rep("Lung", 20))))
t.test(GeneA ~ Type)

(GeneB <- c(rep(-1,30), rep(2,20))+rnorm(50))
t.test(GeneB ~ Type)

rm(list = ls()) # clear the enviroment

