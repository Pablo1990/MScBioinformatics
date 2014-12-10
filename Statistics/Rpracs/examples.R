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


rainbow(nlevels(anage$Class))[anage$Class]


pdf(file = "m1.pdf", height = 4, width = 4)
#all of the instructions since this point will be writed on the m1 file
plot(1:5, col = "blue")
#until I wrote the next instruction
dev.off()

is.na(vector)

getwd()
ls()
setwd()

write.table(anther.data.set, file = "unfichero.txt", quote= FALSE, row.names = FALSE, sep = "@")

source("file", echo = TRUE, max.deparse.length = 988999999) 
#execute the "file", echo= print all the instructions, max.deparse.length = the max number of instructions

#Terminal time:
# nohup R CMD BATCH executing file
#executing files on background. You must do this, if you run some scripts for a long time.

# & check all the elements of the operator like: 1 & 2
# && it works like a dead short, if the first element is false, the next elements doesn't get evelauted