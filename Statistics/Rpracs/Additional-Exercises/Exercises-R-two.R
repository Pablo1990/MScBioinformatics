
## ----error=FALSE, include=FALSE, cache=FALSE-----------------------------
require(knitr, quietly = TRUE)
opts_knit$set(concordance = TRUE)
opts_chunk$set(size= "small", error=FALSE)
## opts_knit$set(stop_on_error = 2L)
## mytry <- function(x) try(x) ## eliminate?


## ----echo=FALSE,eval=TRUE,results='hide'---------------------------------
rm(list = ls())
options(width = 68)


## ----loadingData,cache=TRUE,echo=FALSE-----------------------------------
## Just do it once, store it and later just load the data
leuk.dat <- read.table("leukemia.data.txt", row.names = 1)
leuk.class <- factor(scan("leukemia.class.txt", what = ""))

sex <-factor(rep(c("Male", "Female"), length.out = 38))
leuk.dat.m <- data.matrix(leuk.dat)



## ----echo=FALSE----------------------------------------------------------
table(sex)


## ----echo=FALSE----------------------------------------------------------
table(sex, leuk.class)


## ----echo=FALSE----------------------------------------------------------
xtabs( ~ sex + leuk.class)


## ----echo=FALSE,show=FALSE-----------------------------------------------
mytable <- xtabs( ~ sex + leuk.class)
## mytable


## ----echo=TRUE-----------------------------------------------------------
as.data.frame(mytable)


## ----echo=FALSE,cache=TRUE-----------------------------------------------
p.v.t <- apply(leuk.dat, 1, function(x) t.test(x ~ leuk.class)$p.value)


## ----echo=FALSE----------------------------------------------------------
mean(leuk.dat.m[p.v.t < 0.01, 3])


## ----echo=FALSE----------------------------------------------------------
median(leuk.dat.m[2, sex == "Male"])


## ------------------------------------------------------------------------
leuk.dat.t <- t(leuk.dat.m)


## ------------------------------------------------------------------------
dim(leuk.dat.t)


## ------------------------------------------------------------------------
leuk.dat.t[1:5, 1:6]


## ----echo=FALSE,eval=TRUE------------------------------------------------
aggregate(leuk.dat.t[, c(1, 2124, 2600)], 
          list(type = leuk.class), median)



## ----echo=FALSE,eval=TRUE------------------------------------------------

aggregate(leuk.dat.t[, c(1, 2124, 2600)], 
          list(type = leuk.class, sex = sex), median)



## ----echo=FALSE,eval=TRUE------------------------------------------------

all.median <- aggregate(leuk.dat.t, 
                        list(type = leuk.class, sex = sex), median)



## ----echo=FALSE----------------------------------------------------------
all.median[, 1:10]


## ------------------------------------------------------------------------
dim(all.median)


## ----echo=FALSE----------------------------------------------------------
aggregate(leuk.dat.t[, c(1, 2124, 2600)], 
          list(type = leuk.class, sex = sex), 
          function(x) c(mean = mean(x), sd = sd(x)))



## ----echo=FALSE----------------------------------------------------------
by(leuk.dat.t[, c(1, 2124, 2600)], 
   list(type = leuk.class, sex = sex), summary)




## ----echo=FALSE----------------------------------------------------------
aggregate(leuk.dat.t[, c(1, 2124, 2600)], 
          list(type = leuk.class, sex = sex), summary)


## ----eval=FALSE----------------------------------------------------------
## class(objeto)


