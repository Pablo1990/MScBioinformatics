
## ----setup,include=FALSE,cache=FALSE-------------------------------------
require(knitr)
opts_knit$set(concordance = TRUE)
opts_knit$set(stop_on_error = 2L)
## next are for listings, to produce HTML
##listings-knitr-html%%options(formatR.arrow = TRUE)
##listings-knitr-html%%render_listings()


## ----include=FALSE-------------------------------------------------------
rm(list = ls())
options(width = 67)


## ----eval=TRUE,tidy=FALSE, fig.height=5----------------------------------
randomdata <- matrix(rnorm(50 * 1000), ncol = 50)
class <- factor(c(rep("NC", 20), rep("cancer", 30)))
pvalues <- apply(randomdata, 1, 
                 function(x) t.test(x ~ class)$p.value)
hist(pvalues)
sum(pvalues < 0.05)


## ----eval=FALSE----------------------------------------------------------
## install.packages("car")


## ----eval=FALSE----------------------------------------------------------
## install.packages(c("RJaCGH", "varSelRF"))


## ----eval=FALSE----------------------------------------------------------
## install.packages("car")


## ----eval=FALSE----------------------------------------------------------
## q()


## ------------------------------------------------------------------------
1 + 2


## ------------------------------------------------------------------------
1:40


## ------------------------------------------------------------------------
v1 <- 1 + 2


## ------------------------------------------------------------------------
v1


## ------------------------------------------------------------------------
print(v1)


## ------------------------------------------------------------------------
(v1 <- 1 + 2)


## ------------------------------------------------------------------------
v1 <- 1 + 2; v1


## ------------------------------------------------------------------------
v11 <- 3 * ( 5 + sqrt(13) - 3^(1/(4 + 1)))


## ------------------------------------------------------------------------
v3 <- 5
(v4 <- v1 + v3)
(v5 <- v1 * v3)
(v6 <- v1 / v3)


## ------------------------------------------------------------------------
(z2 <- 33)
z2 <- 999
z2
z2 <- "Now z2 is a sentence"
z2


## ------------------------------------------------------------------------
rm(z2)


## ----eval=FALSE----------------------------------------------------------
## help(mean)


## ----eval=FALSE----------------------------------------------------------
## ?mean


## ----eval=FALSE----------------------------------------------------------
## ?help
## ?apropos


## ----eval=FALSE----------------------------------------------------------
## ?normal
## ?rnorm
## apropos("normal")
## apropos("norm")
## help.search("normal")


## ----eval=FALSE----------------------------------------------------------
## example(rnorm)
## example(graphics)
## example(lm)


## ----eval=FALSE----------------------------------------------------------
## demo(graphics)


## ----eval=FALSE----------------------------------------------------------
## apply(F, 1, mean)
## log("23")
## rnorm("a")
## lug(23)
## rnorm(23, 1, 1, 1, 34)
## x <- 1:10
## y <- 11:21
## plot(x, y)
## lm(y ~ x)
## z <- 1:10
## t.test(x ~ z)


## ------------------------------------------------------------------------
hit <- read.table("hit-table-500-text.txt")
## We know, from the header of the file, that
## alignment length is the fifth column,
## score is the 13th and percent identity the 3rd
hist(hit[, 5]) ## the histogram
plot(hit[, 13] ~ hit[, 3]) ## the scatterplot


## ----fig-blast,fig.height=4,fig.width=6, fig.cap="A quick look at the alignment results",fig.lp=''----
par(mfrow = c(1, 2)) ## two figures side by side
hist(hit[, 5], breaks = 50, xlab = "", main = "Alignment length")
plot(hit[, 13] ~ hit[, 3], xlab = "Percent. identity", 
     ylab = "Bit score")


## ----eval=FALSE----------------------------------------------------------
## library(car)
## scatter3d(hit[, 13] ~ hit[, 3] + hit[, 5], xlab = "Ident",
##           zlab = "Length", ylab = "Score")


## ----eval=FALSE,results='hide'-------------------------------------------
## help(rnorm)
## help(runif)
## help(rpois)


## ------------------------------------------------------------------------
rnorm(5)


## ------------------------------------------------------------------------
set.seed(2)


## ------------------------------------------------------------------------
GeneA <- rnorm(50)
round(GeneA, 3)
(Type <- factor(c(rep("Colon", 30), rep("Lung", 20))))


## ------------------------------------------------------------------------
t.test(GeneA ~ Type)


## ------------------------------------------------------------------------
(GeneB <- c(rep(-1, 30), rep(2, 20)) + rnorm(50))
t.test(GeneB ~ Type)


## ----fig.width=7,fig.height=7--------------------------------------------
par(mfrow = c(2, 2)) ## a 2-by-2 layout
boxplot(GeneA ~ Type)
stripchart(GeneA ~ Type, vertical = TRUE, pch = 1)
boxplot(GeneB ~ Type)
stripchart(GeneB ~ Type, vertical = TRUE, pch = 1)


## ------------------------------------------------------------------------
load("Additional_files_R-bioinfo-intro/anage.RData")
ls() ## a new anage object is present


## ------------------------------------------------------------------------
str(anage)
head(anage)
summary(anage)


## ----fig.width=6, fig.height=6-------------------------------------------
library(car) ## make the car package available; this is NOT 
             ## installing it. It is making it available
scatterplot(Metabolic.rate..W. ~ Body.mass..g., log="xy", 
            data = anage)


## ----fig.width=6, fig.height=6-------------------------------------------
plot(Metabolic.rate..W. ~ Body.mass..g., log="xy", data = anage)


## ----fig.width=4,fig.height=4--------------------------------------------
plot(Metabolic.rate..W. ~ Body.mass..g., log="xy", 
     col = c("salmon", "darkgreen")[Class], data = anage)
legend(5, 5, legend = levels(anage$Class), 
       col = c("salmon", "darkgreen"),
       pch = 1)


## ----fig.width=4,fig.height=4--------------------------------------------
scatterplot(Metabolic.rate..W. ~ Body.mass..g.|Class, log="xy", 
            data = anage)


## ------------------------------------------------------------------------
anage$logMetab <- log(anage$Metabolic.rate..W.) #We add the two atributes (logMetab, logBodyMass) to "anage"
anage$logBodyMass <- log(anage$Body.mass..g.)


## ------------------------------------------------------------------------
birds <- subset(anage, Class == "Aves")


## ------------------------------------------------------------------------
birds <- anage[anage$Class == "Aves", ]


## ------------------------------------------------------------------------
(lm1 <- lm(logMetab ~ logBodyMass, data = birds))


## ------------------------------------------------------------------------
summary(lm1) #the object (Intercept) seems to be not relevant.
#In this case, the relevant one is logBodyMass, and it represents the slope.


## ------------------------------------------------------------------------
names(lm1)
lm1$coefficients


## ------------------------------------------------------------------------
coef(lm1)


## ------------------------------------------------------------------------
plot(logMetab ~ logBodyMass, data = birds)
abline(lm1)


## ------------------------------------------------------------------------
scatterplot(logMetab ~ logBodyMass, data = birds)


## ----eval=FALSE----------------------------------------------------------
## anage <-  read.table("AnAge_birds_reptiles.txt",
##                      header=TRUE, na.strings="NA",
##                      strip.white=TRUE)
## save(file = "anage.RData", anage)


## ----pchcol,fig.width=7,fig.height=4, fig.cap='pch and col', fig.lp='fig:'----
plot(c(1, 21), c(1, 2.3),
     type = "n", axes = FALSE, ann = FALSE)
## show pch
points(1:20, rep(1, 20), pch = 1:20)
text(1:20, 1.2, labels = 1:20)
text(11, 1.5, "pch", cex = 1.3)

## show colors for rainbow palette
points(1:20, rep(2, 20), pch = 16, col = rainbow(20))
text(11, 2.2, "col", cex = 1.3)

## ----ltytype,fig.width=4,fig.height=4, fig.cap='lty for values 1 to 6', fig.lp='fig:'----
plot(c(0.2, 5), c(0.2, 5), type = "n", ann = FALSE, axes = FALSE)
for(i in 1:6) {
    abline(0, i/3, lty = i, lwd = 2)
    text(2, 2 * (i/3), labels = i, pos = 3)
}



## ----eval=FALSE----------------------------------------------------------
## demo(graphics)
## example(graphics)
## example(persp)
## demo(persp)


## ----eval=FALSE----------------------------------------------------------
## example(qplot)


## ----eval=FALSE----------------------------------------------------------
## X <- read.table("hit-table-500-text.txt")
## head(X)
## ## We could save what we care about in variables
## ## with better names
## align.length <- X[, 5]
## score <- X[, 13]
## 


## ------------------------------------------------------------------------
another.data.set <- read.table("AnotherDataSet.txt", 
                               header = TRUE)
summary(another.data.set)


## ------------------------------------------------------------------------
write.table(another.data.set, 
            file = "the.table.I.just.saved.txt")


## ----echo=TRUE,results="hide"--------------------------------------------
save.image(file = "this.RData")
getwd()


## ----echo=FALSE,eval=TRUE,results='hide'---------------------------------
rm(list = ls())


## ------------------------------------------------------------------------
ls()


## ----eval=FALSE----------------------------------------------------------
## load("this.RData")
## ls()
## v1
## v11
## summary(another.data.set)


## ----eval=FALSE----------------------------------------------------------
## save.image()


## ----fig.width=3, fig.height=3-------------------------------------------
source("script1.R", echo = TRUE, 
       max.deparse.length = 999999)


## ------------------------------------------------------------------------
v1 <- c(1, 2, 3)
v2 <- c("a", "b", "cucu")
v3 <- c(1.9, 2.5, 0.6)


## ------------------------------------------------------------------------
log(v1)
exp(v3)
2 * v1
v3/0.7


## ------------------------------------------------------------------------
seq(from = 1, to = 10)
seq(from = 1, to = 10, by = 2)
seq(from = 1, to = 10, length.out = 3)
1:5


## ------------------------------------------------------------------------
rep(2, 5)
rep(1:3, 2)
rep(1:3, 2:4)


## ------------------------------------------------------------------------
v1 <- 1:4
v2 <- 7:12
(v3 <- c(v1, v2))


## ------------------------------------------------------------------------
v1 <- 2:8
(v2 <- 3 + v1)


## ------------------------------------------------------------------------
v1 <- 1:5
v2 <- 11:15
(v3 <- v1 + v2)


## ------------------------------------------------------------------------
v1 <- 1:3
v2 <- 11:12
v1 + v2


## ------------------------------------------------------------------------
v1 <- 1:3
v2 <- 11:16
v1 + v2


## ----eval=FALSE----------------------------------------------------------
## ?Comparison
## ?Logic


## ------------------------------------------------------------------------
v1 <- 1:5
v1 < 3
(v2 <- (v1 < 3))
v11 <- c(1, 1, 3, 5, 4)
v1 == v11
v1 != v11
!(v1 == v11)
identical(v1, v11)
v3 <- c(TRUE, FALSE, TRUE, FALSE, TRUE)
!v3
v2 & v3
v2 | v3
(v1 > 3) & (v11 >= 2)
(v1 > 3) | (v11 >= 2)
xor(v2, v3)


## ------------------------------------------------------------------------
vv <- c(1, 3, 10, 2, 9, 5, 4, 6:8)


## ------------------------------------------------------------------------
length(which(vv < 5))


## ------------------------------------------------------------------------
vv < 5
vv.2 <- (vv < 5)
vv.2
which(vv.2)
vv.3 <- which(vv.2)
vv.3
length(vv.3)


## ------------------------------------------------------------------------
length(vv[vv < 5])


## ------------------------------------------------------------------------
vv[vv < 5]


## ------------------------------------------------------------------------
sum(vv < 5)


## ------------------------------------------------------------------------
times.run  <-  c(first=9,second=12,third=17)
names(times.run)

ages <- c(Juan = 23, Maria = 35, Irene = 12, Ana = 93)
ages


## ------------------------------------------------------------------------
(w <- 9:18)
w[1]
w[2]
w[c(4, 3, 2)]


## ------------------------------------------------------------------------
w[c(1, 3)] ## not the same as
w[c(3, 1)]


## ------------------------------------------------------------------------
w[1:2]
w[3:6]
w[seq(1, 8, by = 3)]
vv <- seq(1, 8, by = 3)
w[vv]


## ------------------------------------------------------------------------
w[-1]
w[-c(1, 3)] ## of course, the same as following
w[-c(3, 1)]


## ------------------------------------------------------------------------
(times.run  <-  c(first=9,second=8,third=7))
times.run["second"]
times.run[c("first", "second", "first", "third")]

ages <- c(Juan = 23, Maria = 35, Irene = 12, Ana = 93)
ages["Irene"]
ages[c("Irene", "Juan")]


## ------------------------------------------------------------------------
ages[c(FALSE, TRUE, TRUE, FALSE)]
ages[c(FALSE, TRUE)] ## what is this doing?


## ------------------------------------------------------------------------
## All less than 12
w[w < 12]
## same, but more confusing (here, not always)
w[!(w >= 12)]

## All less than the median
w[w < median(w)]


## ------------------------------------------------------------------------
ages["Irene"] <- 19
ages
w[1] <- 9999
w
w[vv] <- 103
w


## ------------------------------------------------------------------------
x  <-  1.999999
x
x - 2
x <- 1.9999999999999
x
x-2


## ----tidy=FALSE----------------------------------------------------------

Sex.version1 <- factor(c("Female", "Female", "Female", 
                         "Male", "Male"))
Sex.version2 <- factor(c("XX", "XX", "XX", "XY", "XY"))
Sex.version3 <- factor(c("Feminine", "Feminine", "Feminine", 
                         "Masculine", "Masculine"))
Sex.version4 <- factor(c("fe", "fe", "fe", "ma", "ma"))



## ------------------------------------------------------------------------
postal.code <- c(28001, 28001, 28016, 28430, 28460)
somey <- c(10, 20, 30, 40, 50)
summary(aov(somey ~ postal.code))


## ----eval=TRUE-----------------------------------------------------------
x <- c(34, 89, 1000)
y <- factor(x)
y
as.numeric(y)
y


## ----eval=TRUE-----------------------------------------------------------
as.numeric(as.character(y))


## ------------------------------------------------------------------------
as.character(y)


## ------------------------------------------------------------------------
matrix(1:10, ncol = 2)
matrix(1:10, nrow = 5)
matrix(1:10, ncol = 2, byrow = TRUE)


## ------------------------------------------------------------------------
v1 <- 1:5
v2 <- 11:15
rbind(v1, v2)
cbind(v1, v2)


## ------------------------------------------------------------------------
A <- matrix(1:10, nrow = 5)
B <- matrix(11:20, nrow = 5)
cbind(A, B)
rbind(A, B)


## ------------------------------------------------------------------------
A <- matrix(1:15, nrow = 5)
A[1, ] ## first row
A[, 2] ## second column
A[4, 2] ## fourth row, second column
A[3, 2] <- 999
A[1, ] <- c(90, 91, 92)
A < 4


## ------------------------------------------------------------------------
which(A == 999)


## ------------------------------------------------------------------------
which(A == 999, arr.ind = TRUE)


## ------------------------------------------------------------------------
B <- A
colnames(B) <- c("A", "E", "I")
rownames(B) <- letters[1:nrow(B)]
B[, "E"]
B["c", ]


## ------------------------------------------------------------------------
(m1 <- cbind(c(1, 3), c(2, 1)))
A[m1]
## compare with
A[c(1, 3), c(2, 1)]


## ------------------------------------------------------------------------
sum(B)
mean(B)
colSums(B)
rowMeans(B)


## ------------------------------------------------------------------------
B[rowMeans(B) > 9, ]


## ------------------------------------------------------------------------
listA <- list(a = 1:5, b = letters[1:3])
listA[[1]]
listA[["a"]]
listA$a


## ------------------------------------------------------------------------
listA[[1]][2]


## ------------------------------------------------------------------------
listA[1]


## ----tidy=FALSE----------------------------------------------------------
(listB <- list(one.vector = 1:10,  hello = "Hola", 
               one.matrix = matrix(rnorm(20), ncol = 5),
               another.list = 
               list(a = 5, 
                    b = factor(c("male", 
                      "female", "female")))))


## ------------------------------------------------------------------------
(AB <- read.table("AnotherDataSet.txt", 
                  header = TRUE))


## ------------------------------------------------------------------------
AB[2, 3]
AB[1, ]
AB["2", ] ## using the rownames
AB[, "Age"]
AB$Age
AB[["Age"]]
AB[3, 4] <- 97


## ------------------------------------------------------------------------
data.matrix(AB)
as.matrix(AB)


## ------------------------------------------------------------------------
AB2 <- rbind(AB, AB)


## ------------------------------------------------------------------------
(AC <- data.frame(ID = "a9", Age = 14, Sex = "M", Y = 17))
rbind(AB, AC)


## ------------------------------------------------------------------------
AB2$status <- rep(c("Z", "V"), 5)


## ------------------------------------------------------------------------
table(AB2$Sex)
with(AB2, table(Sex, status)) ## note "with"
xtabs( ~ Sex + status, data = AB2)


## ------------------------------------------------------------------------
(freqs <- as.data.frame(xtabs( ~ Sex + status, data = AB2)))


## ----results='hide'------------------------------------------------------
table(AB)


## ------------------------------------------------------------------------
AC <- AB2[, c("Sex", "status")]
table(AC)


## ------------------------------------------------------------------------
x <-  data.frame(a = c(1,2,2,1,2,2,1),
                 b = c(1,2,2,1,1,2,1),
                 c = c(1,1,2,1,2,2,1))

## tabulate: so create a data frame with a "Freq" column
dfx <- as.data.frame(table(x))

## Recover the table
xtabs(Freq ~ a + b + c, data = dfx)
## of course, this is the same
xtabs(~ a + b + c, data = x)


## ------------------------------------------------------------------------
y <- x
y$d <- y$a + 1

## table of b, c, d, counts are the a
## (this is like example above with Freq on the left)
xtabs(a ~ ., data = y)
## table of c, d; counts are the a and the b 
## (instead of just "a" or Freq)
## "columns are intrepreted as the levels of a variable"
xtabs(cbind(a, b) ~ ., data = y)
## the usual table of all
xtabs(~ c + d + a + b, data = y)
## maybe easier to see?
ftable(y)

## One more twist: 
## "columns are intrepreted as the levels of a variable"
y$e <- y$a + y$c + 9 
xtabs(cbind(a, b, e) ~ ., data = y)


## ------------------------------------------------------------------------
names.of.friends <- c("Ana", "Rebeca", "Marta", 
                      "Quique", "Virgilio")
for(friend in names.of.friends) {
  cat("\n I should call", friend, "\n")
}


## ----lty2,fig.cap='Those line types (lty) again',fig.width=4, fig.height=4----
plot(c(0, 10), c(0, 10), xlab ="", ylab ="", type = "n")
for(i in 1:10) 
  abline(h = i, lty = i, lwd = 2)



## ------------------------------------------------------------------------

x <- y <- 0
iteration <- 1
while( (x < 10) & (y < 2)) {
  cat(" ... iteration", iteration, "\n")
  x <- x + runif(1)
  y <- y + rnorm(1)
  iteration <- iteration + 1
}

x
y



## ----results='hide'------------------------------------------------------
iteration <- 0
while(TRUE) {
  iteration <- iteration + 1
  cat(" ... iteration", iteration, "\n")
  x <- rnorm(1, mean = 5)
  y <- rnorm(1, mean = 7)
  z <- x * y
  if (z < 15) break
}



## ------------------------------------------------------------------------
multByTwo <- function(x) {
  z <- 2 * x
  return(z)
}

a <- 3
multByTwo(a)
multByTwo(45)


## ------------------------------------------------------------------------
plotAndSummary <- function(x) {
  plot(x)
  print(summary(x))
}
x <- rnorm(50)


## ----results="hide",fig.keep="none"--------------------------------------
plotAndSummary(x)
plotAndSummary(runif(24))


## ------------------------------------------------------------------------
plotAndLm <- function(x, y, title = "A figure") {
  lm1 <- lm(y ~ x)
  cat("\n Printing the summary of x\n")
  print(summary(x))
  cat("\n Printing the summary of y\n")
  print(summary(y))
  cat("\n Printing the summary of the linear regression\n")
  print(summary(lm1))
  plot(y ~ x, main = title)
  abline(lm1)
  return(lm1)
}

x <- 1:20
y <- 5 + 3 *x + rnorm(20, sd = 3)


## ----results="hide",fig.keep="none",-------------------------------------
plotAndLm(x, y)
plotAndLm(x, y, title = "A user specified title")
output1 <- plotAndLm(x, y, title = "A user specified title")


## ----results="hide",fig.keep="none"--------------------------------------
plotAndLm(x, y)


## ----results="hide",fig.keep="none"--------------------------------------
out2 <- plotAndLm(x, y)


## ----eval=FALSE----------------------------------------------------------
## f1 <- function(x) {
##     x + z
## }


## ----eval=FALSE----------------------------------------------------------
## v <- 1000
## f3 <- function(x, y) {
##     v <- 3 * x
##     f2 <- function(u) {
##         u + v
##     }
##     f2(y)
## }
## f3(2, 9)


## ------------------------------------------------------------------------
c
c <- 95
c
c(5, 6)
c + 8


## ----eval=FALSE----------------------------------------------------------
## search()


## ------------------------------------------------------------------------
rm(c)


## ------------------------------------------------------------------------
(Z <- matrix(c(1, 27, 23, 13), nrow = 2))
apply(Z, 1, median)
apply(Z, 2, median)
apply(Z, 2, min)


## ----tidy=FALSE----------------------------------------------------------
(listA <- list(one.vector = 1:10,  hello = "Hola", 
               one.matrix = matrix(rnorm(20), ncol = 5),
               another.list = list(a = 5, 
                 b = factor(c("male", "female", "female")))))

lapply(listA, function(x) x[[1]])


## ----tidy=FALSE----------------------------------------------------------
(one.dataframe <- data.frame(age = c(12, 13, 16, 25, 28), 
                            sex = factor(c("male", "female", 
                              "female", "male", "male"))))

tapply(one.dataframe$age, one.dataframe$sex, mean)


## ----tidy=FALSE----------------------------------------------------------
(one.dataframe <- data.frame(age = c(12, 13, 16, 25, 28), 
                            sex = factor(c("male", "female", 
                              "female", "male", "male"))))

aggregate(one.dataframe$age, list(one.dataframe$sex), mean)
## make the aggregating variable explicit, 
## and give it another name
aggregate(one.dataframe$age, 
          list(Sexo = one.dataframe$sex), mean)

## or use the name of the column/variable
aggregate(one.dataframe$age, 
          one.dataframe[2], mean)


## ------------------------------------------------------------------------
by(one.dataframe$age, list(one.dataframe$sex), 
   function(x) c(mean(x), sd(x)))


## ------------------------------------------------------------------------
(E <- matrix(1:9, nrow = 3))
E[, 1]
E[, 1, drop = FALSE]
E[1, ]
E[1, , drop = FALSE]



## ------------------------------------------------------------------------
rows.of.interest <- c(1, 3)


## ------------------------------------------------------------------------
apply(E[rows.of.interest, ], 1, median)



## ------------------------------------------------------------------------
rows.of.interest <- c(3)


## ----eval=FALSE----------------------------------------------------------
## apply(E[rows.of.interest, ], 1, median)


## ------------------------------------------------------------------------
apply(E[rows.of.interest, , drop = FALSE], 1, median)


## ----eval=TRUE,results='hide'--------------------------------------------
randomdata <- matrix(rnorm(50 * 500), ncol = 50)
class <- factor(c(rep("NC", 20), rep("cancer", 30)))


## ------------------------------------------------------------------------
 
tmp <- t.test(randomdata[1, ] ~ class)
tmp
attributes(tmp)
tmp$p.value


## ----fig.keep="none",eval=TRUE,results='hide'----------------------------
 
pvalues <- apply(randomdata, 1, 
                 function(x) t.test(x ~ class)$p.value)
hist(pvalues)
order(pvalues)
which(pvalues < 0.05)

## ----results='hide'------------------------------------------------------
sum(pvalues < 0.05)


## ----fig.keep="none",results='hide'--------------------------------------
source("lastExample.R")
sum(pvalues < 0.05)


## ------------------------------------------------------------------------
f1 <- function(x) 3 * x

f2 <- function(x) 5 + f1(x)

f3 <- function(z, u) {
    v <- runif(z)
    a <- f2(u)
    b <- f2(3 * v)
    return(a + b)
}
f3(3, 7)


## ----eval=FALSE,error=TRUE-----------------------------------------------
## f3(-5, 6)
## traceback()
## 
## f3(5, "a")
## traceback()


## ----eval=FALSE----------------------------------------------------------
## debug(f4)
## f3(3, 5)
## undebug(f3) ## stop debugging
## f3(3, 5)


## ----eval=FALSE----------------------------------------------------------
## f3(3, 5)
## f3(3, 11)


## ------------------------------------------------------------------------
f3 <- function(z, u) {
    v <- runif(z)
    if (z > 5) browser()
    a <- f2(u)
    b <- f2(3 * v)
    return(a + b)
}


## ----eval=FALSE----------------------------------------------------------
## as.list(body(f3))
## trace(f3, tracer = browser, at = 3)
## 
## f3 # notice the message


## ----eval=FALSE----------------------------------------------------------
## f3(4, 5)
## untrace(f3) ## stop tracing


## ----eval=FALSE----------------------------------------------------------
## as.list(body(lm))
## trace(lm, tracer = browser, at = 5)
## y <- runif(100)
## x <- 1:100
## lm(y ~ x)
## ## stop tracing
## untrace(lm)


## ----eval=FALSE----------------------------------------------------------
## opt <- options(error = recover)
## ## Notice the next show, as they should,
## ## different frame numbers. The error is in different
## ## places. You can enter in the relevant frames
## ## and look around
## f3(3, "a")
## f3(-5, 3)


## ----eval=FALSE----------------------------------------------------------
## options(opt)


## ----eval=FALSE----------------------------------------------------------
## f1 <- function(x) 3 * x
## 
## f2 <- function(x) 5 + f1(x)
## 
## f3 <- function(z, u) {
##     v <- runif(z)
##     f2(v + u)
## }
## f3(3, "a")


## ----eval=FALSE----------------------------------------------------------
## opt <- options(warn = 2)


## ----eval=FALSE----------------------------------------------------------
## options(opt)


## ----eval=FALSE----------------------------------------------------------
## debug(f1); debug(f2); debug(f3)
## f3(4, 5) ## now, keeping pressing enter or n
##          ## and you'll get deeper and deeper
##          ## while in browser mode, type where


## ----eval=FALSE----------------------------------------------------------
## undebug(f3)
## undebug(f2)
## undebug(f1)


## ------------------------------------------------------------------------
ft <- function(x) {
    tmp <- try(log(x), silent = TRUE)
    if(inherits(tmp, "try-error")) {
        warning(paste("It looks like something did not work:\n",
                      "   ", tmp))
    } else{
        return(tmp)
    }
}

ft(9)
ft("a")


## ------------------------------------------------------------------------
A <- scan("Condition_A.txt", what = "")
B <- scan("Condition_B.txt", what = "")
C <- scan("Condition_C.txt", what = "")


## ------------------------------------------------------------------------
sort(intersect(A, B))
sort(intersect(A, intersect(B, C)))


## ------------------------------------------------------------------------
####   Read all lists of genes that start with "Condition" 
####    and store   as a list
gf <- dir(pattern = "^Condition_")
ovxpGenes <-  sapply(gf, function(x) scan(x, what = ""))


## ------------------------------------------------------------------------
names(ovxpGenes) <- 
    sapply(names(ovxpGenes), 
           function(x) strsplit(strsplit(x, 
                                         "Condition_")[[1]][2], 
                                "\\.txt")[[1]][1])



## ----eval=FALSE----------------------------------------------------------
## ## First line is to get the ovxpGenes names
## ovxpGenes <-  sapply(gf, function(x) scan(x, what = ""))
## 
## names(ovxpGenes) <- sapply(strsplit(names(ovxpGenes),
##                                     "Condition_"),
##                            function(x)
##                                strsplit(x[[2]], "\\.txt")[[1]][1])


## ------------------------------------------------------------------------
all.the.genes <- sort(unique(unlist(ovxpGenes)))


## ------------------------------------------------------------------------
head(match(ovxpGenes[[1]], all.the.genes))


## ------------------------------------------------------------------------
str(sapply(ovxpGenes, function(z) {match(z, all.the.genes)}))


## ------------------------------------------------------------------------
f1 <- function(x, all.the.genes) {
    ## Note: this could be done in fewer lines, or even
    ## by an anonymous function used in sapply
    vv <- rep(FALSE, length(all.the.genes))
    pos.match <- match(x, all.the.genes)
    vv[pos.match] <- TRUE
    return(vv)
}


## ------------------------------------------------------------------------
head(f1(ovxpGenes[[1]], all.the.genes))
## and on the third?
head(f1(ovxpGenes[[3]], all.the.genes))


## ------------------------------------------------------------------------
overexpressed <- sapply(ovxpGenes, 
                        function(x) f1(x, all.the.genes))
rownames(overexpressed) <- all.the.genes


## ------------------------------------------------------------------------
overexpressed <- vapply(ovxpGenes, 
                        function(x) f1(x, all.the.genes), 
                        logical(length(all.the.genes)))
rownames(overexpressed) <- all.the.genes


## ------------------------------------------------------------------------
## note the following two match
colSums(overexpressed)
lapply(ovxpGenes, length)
# But if automatic, better to use stopifnot
stopifnot(colSums(overexpressed) == 
              unlist(lapply(ovxpGenes, length)))

## And check names of genes
h <- rownames(overexpressed)[which(overexpressed[, "A"] == 1)]
stopifnot(identical(h, sort(ovxpGenes[["A"]])))


## ------------------------------------------------------------------------
library(limma)
vennDiagram(overexpressed)


## ------------------------------------------------------------------------
which(overexpressed[, "A"] & overexpressed[, "B"])


## ------------------------------------------------------------------------
which(rowSums(overexpressed) == 3)
## or safer?
which(rowSums(overexpressed) > 2.99)


## ------------------------------------------------------------------------
table(rowSums(overexpressed))


## ------------------------------------------------------------------------
sort(Reduce(intersect, ovxpGenes))


## ------------------------------------------------------------------------
readListGenes <- function(prefix = "Condition_", 
                          postfix = "txt") {
    ## Read a bunch of files, named "prefixSOMETHING.postfix",
    ## and place the gene names inside in a list
    gg <- dir(pattern = paste0("^", prefix))
    ovG <-  sapply(gg, function(x) scan(x, what = ""))
    matchpost <- paste0("\\.", postfix)
    names(ovG) <- 
    sapply(names(ovG), 
           function(x) strsplit(strsplit(x, 
                                         prefix)[[1]][2], 
                                matchpost)[[1]][1])
    return(ovG)
}


## ------------------------------------------------------------------------
trueIfMatch <- function(x, allgenes) {
    ## Note: this could be done in fewer lines, or even
    ## by an anonymous function used in sapply
    vv <- rep(FALSE, length(allgenes))
    pos.match <- match(x, allgenes)
    vv[pos.match] <- TRUE
    return(vv)  
}
geneListToMatrix <- function(lgenes) {
    ## For you: add a meaningful comment here!
    allgenes <- sort(unique(unlist(lgenes)))
    ox <- vapply(lgenes, 
                 function(x) trueIfMatch(x, allgenes), 
                 logical(length(allgenes)))
    rownames(ox) <- allgenes  
    return(ox)
}


## ------------------------------------------------------------------------
geneFiles2Mat <- function(prefix = "Condition_", 
                          postfix = "txt") {
    l1 <- readListGenes(prefix = prefix, postfix = postfix)
    return(geneListToMatrix(l1))
}


## ------------------------------------------------------------------------
ovxABC <- geneFiles2Mat()


## ------------------------------------------------------------------------
stopifnot(identical(sort(Reduce(intersect, ovxpGenes)),
                    sort(Reduce(intersect, readListGenes()))
                    ))

stopifnot(identical(ovxABC, overexpressed))


## ------------------------------------------------------------------------
# no difference
d11 <- rnorm(15)
d12 <- d11[1:7]
# difference
d21 <- rnorm(13)
d22 <- d21[1:9] + 3


## ----results='hide'------------------------------------------------------
t.test(d11, d12)
t.test(d21, d22)


## ------------------------------------------------------------------------
# for steps 1 and 3
mean.d <- function(x1, x2) 
  mean(x1) - mean(x2)

## seems to work
mean.d(d11, d12)


## ------------------------------------------------------------------------
sample.and.stat1 <- function(x1, x2) {
    tmp <- sample(c(x1, x2))
    g1 <- tmp[seq(x1)]
    g2 <- tmp[seq(from = length(x1) + 1, 
                  to = length(tmp))]
    return(mean.d(g1, g2))
}

sample.and.stat2 <- function(x1, x2) {
    indices <- seq(from = 1, 
                   to = length(x1) + length(x2))
    indices1 <- sample(indices, length(x1))
    indices2 <- setdiff(indices, indices1) 
    alldata <- c(x1, x2)
    return(mean.d(alldata[indices1], 
                  alldata[indices2]))
}


## ------------------------------------------------------------------------
set.seed(1) 
sample.and.stat1(d11, d12)
sample.and.stat1(d11, d12)

set.seed(1) 
sample.and.stat2(d11, d12)
sample.and.stat2(d11, d12)


## ------------------------------------------------------------------------
permut.testA <- function(data1, data2, 
                         fsample = sample.and.stat1,
                         num.permut = 100) {
    obs.stat <- mean.d(data1, data2)
    
    permut.stat <- replicate(num.permut, 
                             fsample(data1, data2))
    pv <- (sum(abs(permut.stat) > 
                   abs(obs.stat)) + 1)/(num.permut + 1)
    
    message("\n p-value is ", pv, "\n")
    return(list(obs.stat = obs.stat,
                permut.stat = permut.stat,
                pv = pv))
}


## ------------------------------------------------------------------------
tmp <- permut.testA(d11, d12)
tmp <- permut.testA(d21, d22)


## ------------------------------------------------------------------------
tmp <- permut.testA(d11, d11)
tmp <- permut.testA(d12, d12)


## ------------------------------------------------------------------------
permut.testB <- function(data1, data2, 
                         fsample = sample.and.stat1,
                         num.permut = 100) {
    obs.stat <- mean.d(data1, data2)
    
    permut.stat <- replicate(num.permut, 
                             fsample(data1, data2))
    pv <- (sum(abs(permut.stat) >= 
                   abs(obs.stat)) + 1)/(num.permut + 1)
    
    message("\n p-value is ", pv, "\n")
    return(list(obs.stat = obs.stat,
                permut.stat = permut.stat,
                pv = pv))
}


## ------------------------------------------------------------------------
tmp <- permut.testB(d11, d11)
tmp <- permut.testB(d12, d12)


## ------------------------------------------------------------------------
permut.test <- function(data1, data2, 
                        fsample = sample.and.stat1, 
                        num.permut = 100) {
  obs.stat <- mean.d(data1, data2)
  permut.stat <- replicate(num.permut, 
                           fsample(data1, data2))
  pv <- (sum(abs(permut.stat) >= abs(obs.stat)) + 
         1) / (num.permut + 1)
  message("\n p-value is ", pv, "\n")
  title <- paste(deparse(substitute(data1)), "-",
                 deparse(substitute(data2)))
  subtitle <- paste0("Distribution of permuted statistic.",
           " In red, observed one.") 
  hist(permut.stat, xlim = c(min(obs.stat, 
                      min(permut.stat)),
                      max(obs.stat, 
                          max(permut.stat))),
       main = title, xlab = "", sub = subtitle)
  abline(v = obs.stat, col = "red")
  return(list(obs.stat = obs.stat,
              permut.stat = permut.stat,
              pv = pv))
}


## ----fig.cap='Two examples of permutation tests', fig.width=5, fig.height=9----
par(mfrow = c(2, 1))
tmp <- permut.test(d11, d12, num.permut = 1000)
tmp <- permut.test(d21, d22, num.permut = 1000, 
                   fsample = sample.and.stat2)


## ----results='hide'------------------------------------------------------
## x2 is a data vector
x2 <- rnorm(27)
N <- length(x2)
knumber <- 10  ## the k in k-fold
## In the k-th time, we leave out as testing set those
## subjects that have index.select = 
## Thus, index.select is the vector of indices
index.select <- sample(rep(1:knumber, 
                           length = N), 
                       N, replace = FALSE)

rep(1:knumber, length = N)
table(index.select)
sum(index.select != 1)
sum(index.select != 10)
sum(index.select != 6)


## ----eval=FALSE----------------------------------------------------------
## do.something.with.train.and.test <- function(train, test) {
##     ## As it says, it does something with the
##     ## two sets of data
## }
## 
## for(sample.number in 1:knumber) {
##     x2.train <- x2[index.select != sample.number]
##     x2.test <- x2[index.select == sample.number]
##     do.something.with.train.and.test(x2.train, x2.test)
## }


## ------------------------------------------------------------------------
sessionInfo()


