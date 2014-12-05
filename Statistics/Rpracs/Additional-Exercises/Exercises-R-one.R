
## ----error=FALSE, include=FALSE, cache=FALSE,message=FALSE,echo=FALSE----
require(knitr, quietly = TRUE)
opts_knit$set(concordance = TRUE)
opts_chunk$set(size= "small", error=FALSE)
opts_knit$set(stop_on_error = 2L)
## mytry <- function(x) try(x) ## eliminate?


## ----echo=FALSE,eval=TRUE,results='hide',message=FALSE-------------------
## Sys.setlocale("LC_ALL", "en_IE@euro")
## Sys.setlocale("LC_ALL", "es_ES@euro")
rm(list = ls())
options(width = 60)
library(colorspace)

##library(patchDVI)
## setwd("./Data-sets-1")


## ----loadingData,cache=TRUE,echo=FALSE, results='hide', warning=FALSE----
## Just do it one, store it and later just load the data
leuk.dat <- read.table("leukemia.data.txt", row.names = 1)
leuk.class <- factor(scan("leukemia.class.txt", what = ""))

p.v.t <- apply(leuk.dat, 1, function(x) t.test(x ~ leuk.class)$p.value)
## what will you do with the warnings? what are they about?
p.v.w <- apply(leuk.dat, 1, function(x) wilcox.test(x ~ leuk.class)$p.value)
## save(file = "pvalues-for-exercise1.RData", leuk.dat, leuk.class, p.v.t, p.v.w)

sorted.p <- sort(p.v.t)
sorted.adj.p <- p.adjust(sorted.p, method = "fdr")

## cut.05 <- sorted.p[length(which(sorted.adj.p < 0.05))]
## cut.15 <- sorted.p[length(which(sorted.adj.p < 0.15))]
cut.05 <- sorted.p[sum(sorted.adj.p < 0.05)]
cut.15 <- sorted.p[sum(sorted.adj.p < 0.15)]



## ----echo=FALSE----------------------------------------------------------
sex <-factor(rep(c("Male", "Female"), length.out = 38))
leuk.dat.m <- data.matrix(leuk.dat)



## ----f02, fig.lp='', fig.cap='Boxplot of PTEN (gene 2124) and scatterplot of PTEN vs.\ HK-1 (gene 1). In the scatterplot, a linear fit has been added. Size of symbols is proportional to the expression of gene 2600', echo=FALSE,fig.height=9.5,fig.width=6----

par(mfrow = c(2, 1))
par(pty = "m")
boxplot(unlist(leuk.dat.m[2124, ]) ~ leuk.class,
        col = c("orange", "lightblue"), ylab = "Gene expression (mRNA)",
        xlab = "Patient groups",
        main = "a) Boxplot of PTEN by patient group.")


for.cex <- leuk.dat.m[2600, ] - min(leuk.dat.m[2600, ]) + 1
the.cex <-   2 * for.cex/max(for.cex)


plot(leuk.dat.m[1, ] ~ leuk.dat.m[2124, ]
     , col = diverge_hcl(2)[leuk.class]
     , pch = c(21, 24)[sex]
     , cex = the.cex
##     , bg = c(0, diverge_hcl(2)[2])[leuk.class]
     , xlab = "PTEN"
     , ylab = "HK-1"
     , main = "b) HK-1 vs. PTEN; symbol size proportional to gene 2600"
     )

lclass <- rep(levels(leuk.class), rep(2, 2))
lsex <- rep(levels(sex), 2)
text.legend <- paste(lclass, lsex, sep = ", ")

legend(-1, 1, legend = text.legend,
       pch = c(21, 24)[factor(lsex)],
       col = diverge_hcl(2)[factor(lclass)])
abline(lm(leuk.dat.m[1, ] ~ leuk.dat.m[2124, ]), lty = 2)



## ----echo=TRUE,eval=FALSE------------------------------------------------
## for.cex <- leuk.dat.m[2600, ] - min(leuk.dat.m[2600, ]) + 1
## the.cex <-   2 * for.cex/max(for.cex)


## ----echo=TRUE,eval=FALSE------------------------------------------------
## lclass <- rep(levels(leuk.class), rep(2, 2))
## lsex <- rep(levels(sex), 2)
## text.legend <- paste(lclass, lsex, sep = ", ")


## ----f04,fig.lp='', fig.cap='Conditioning plot of gene 1 vs. gene 2124 conditioned on sex with a smoothed fit.',echo=FALSE----
coplot(leuk.dat.m[1, ] ~ leuk.dat.m[2124, ] | sex,
       panel = panel.smooth,
       xlab = "PTEN", ylab = "HK-1")



## ----f05, fig.lp='', fig.cap='Conditioning plot of gene 1 vs. gene 2124 conditioned on sex with a smoothed fit, using library lattice. This is the same plot as in Figure \ref{f04} but using lattice.',echo=FALSE----

library(lattice)
xyplot(leuk.dat.m[1, ] ~ leuk.dat.m[2124, ] | sex,
             panel = function(x, y) {
                 panel.xyplot(x, y)
                 panel.loess(x, y)
             },
             xlab = "PTEN", ylab = "HK-1")



## ----f06,fig.lp='', fig.cap='Conditioning plot of gene 1 vs. gene 2124 conditioned on sex  with a linear fit, using library lattice. This is like Figure     \ref{f05} but with a linear (instead of a smoothed) fit.',echo=FALSE----

xyplot(leuk.dat.m[1, ] ~ leuk.dat.m[2124, ] | sex,
              xlab = "PTEN", ylab = "HK-1",
       panel = function(x, y) {
           panel.xyplot(x, y)
           panel.lmline(x, y)
       })



## ------------------------------------------------------------------------
dgg <- data.frame(PTEN = leuk.dat.m[2124, ], 
                  HK = leuk.dat.m[1, ],
                  Sex = sex)


## ----fggp,fig.lp='',fig.cap='Yet again the conditioning plot, now using ggplot2',message=FALSE,warning=FALSE,echo=FALSE----
library(ggplot2)

## qplot(PTEN, HK, geom = c("point", "smooth"), 
##       data = dgg) + 
##     facet_wrap( ~ Sex) + labs(y = "HK-1")

ggplot(data = dgg, aes(x = PTEN, y = HK)) + 
    geom_smooth() + geom_smooth(method = lm, se = FALSE, col = "darkgrey") +
        geom_point(shape = 1) + 
        facet_wrap( ~ Sex) + labs(y = "HK-1")



## ----echo=TRUE,eval=FALSE------------------------------------------------
## sorted.p <- sort(p.v.t)
## sorted.adj.p <- p.adjust(something,
##                          method = something_else)


## ----eval=FALSE----------------------------------------------------------
## paste("FDR <= 0.05. P <=", round(cut.05, 4))


## ----f01,fig.lp='',fig.cap='Histogram of p-values from comparing the ALL vs.\ the AML for   each gene with a t-test. The cutting points for the FDR of 0.05 and 0.15  are also shown.',echo=FALSE----
par(las = 1)
hist(p.v.t, freq = FALSE, xlab = "p-value", main = "P-values from t-test",
     breaks = 50, ylim = c(0.3, 14))
abline(h = 1, lty = 2, lwd = 2)

abline(v = cut.05, col = "red", lty = 3)
box()
axis(2, at = 1)
abline(v = cut.15, col = "blue", lty = 4)


legend(x = 0.4, y = 8,
       legend = c(
           paste("FDR <= 0.05. P <=", round(cut.05, 4)),
           paste("FDR <= 0.15. P <= ", round(cut.15, 4))),
       col = c("red", "blue"),
       lty = c(3, 4))


## ----f01b,fig.cap='P-values from comparing the ALL vs.\ the AML with a t-test and a  Wilcoxon test. In the scatterplot for the Wilcoxon vs.\ t-test, the blue  lines shows the threshold for 0.15 FDR computed from the t-test.',fig.lp='',echo=FALSE----
par(pty = "s")
plot(p.v.w ~ p.v.t, xlab = "p-values from t-test",
     ylab = "p-values from Wilcoxon", cex = 0.5)
rug(p.v.t)
rug(p.v.w, side = 2)
abline(v = cut.15, col = "blue", lty = 4)


