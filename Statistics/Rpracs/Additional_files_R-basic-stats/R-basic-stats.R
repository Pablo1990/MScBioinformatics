
## ----setup,include=FALSE,cache=FALSE-------------------------------------
require(knitr)
opts_knit$set(concordance = TRUE)
opts_knit$set(stop_on_error = 2L)
## next are for listings, to produce HTML
##listings-knitr-html%%options(formatR.arrow = TRUE)
##listings-knitr-html%%render_listings()


## ----packages,echo=FALSE,results='hide',message=FALSE--------------------
require(BiocStyle, quietly = TRUE)

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"------------------
BiocStyle::latex()


## ----create_p53, echo=FALSE, results='hide'------------------------------
set.seed(1)
dp53 <- data.frame(p53 = round(rnorm(23, c(rep(2, 13), rep(2.8, 10))), 3), 
                   pten = round(c(rlnorm(13, 1), rlnorm(10, 1.35)), 3),
                   brca1 = round(rnorm(23, c(rep(2, 13), rep(5.8, 10))), 3), 
                   brca2 = round(c(rep(c(1, 2, 3), length.out = 13),
                       rep(c(2, 3, 4), length.out = 10))),
                   cond = rep(c("Cancer", "NC"), c(13, 10)), 
                   id = replicate(23, paste(sample(letters, 10), collapse = "")))
write.table(dp53, file = "P53.txt", col.names = TRUE,
            row.names = FALSE, sep = "\t", quote = FALSE)
rm(list = ls())


## ------------------------------------------------------------------------
dp53 <- read.table("P53.txt", header = TRUE)


## ------------------------------------------------------------------------
require(car)
require(RcmdrMisc)


## ----out.width='11cm',out.height='11cm'----------------------------------
with(dp53, Hist(p53, groups = cond, col = "darkgray"))


## ----fig.height=10, fig.width=8,results='hide'---------------------------
op <- par(mfrow = c(2, 2)) ## to show 2 by 2 on the same figure
Boxplot(p53 ~ cond, data = dp53, id.method = "y")
plotMeans(dp53$p53, dp53$cond, error.bars = "se", 
  xlab = "Condition", ylab = "P53 expression levels")
stripchart(p53 ~ cond, vertical = TRUE, method = "jitter", 
  ylab = "p53", data = dp53)
densityPlot(p53 ~ cond, data = dp53, bw = "SJ", adjust = 1, 
  kernel = "gaussian")
par(op)


## ----fig.width=8, fig.height=8,echo=FALSE--------------------------------
scatterplotMatrix( ~ brca1 + brca2 + p53 + pten | cond, 
                  reg.line = FALSE, 
                  smooth = FALSE, 
                  data = dp53)


## ------------------------------------------------------------------------
t.test(p53 ~ cond, data = dp53)


## ------------------------------------------------------------------------
dp53$logpten <- log(dp53$pten)


## ----results='hide', fig.show='hold', fig.width=5, fig.height=5----------
op <- par(mfrow = c(1, 2))
Boxplot(pten ~ cond, data = dp53, id.method = "y")
Boxplot(logpten ~ cond, data = dp53, id.method = "y")
par(op)


## ------------------------------------------------------------------------
t.test(pten ~ cond, data = dp53)
t.test(logpten ~ cond, data = dp53)


## ----create_myc, echo=FALSE, results = 'hide'----------------------------
set.seed(15)
s <- rnorm(12, 4, 25)
s <- c(s, s)
cond <- rep(c(0, .5), c(12, 12))
y <- rnorm(24) + s + cond
y <- y - min(y) + 0.3
id <- replicate(12, paste(sample(letters, 10), collapse = ""))
id <- c(id, id)
dmyc <- data.frame(myc = round(y, 3), 
                   cond = rep(c("Cancer", "NC"), c(12, 12)), 
                   id = id)

## t.test(myc ~ cond, data = dmyc)
## ## should this work?? It does but from the help it ain't obvious to me
## t.test(myc ~ cond, paired = TRUE, data = dmyc) 
## t.test(myc ~ cond, data = dmyc)
## t.test(myc ~ cond, paired = TRUE, data = dmyc) 
## t.test(dmyc$myc[1:12] - dmyc$myc[13:24])
## summary(lm(myc ~ id + cond, data = dmyc))


write.table(dmyc, file = "MYC.txt", col.names = TRUE,
            row.names = FALSE, sep = "\t", quote = FALSE)


## ------------------------------------------------------------------------
dmyc <- read.table("MYC.txt", header = TRUE)


## ------------------------------------------------------------------------
myc.cancer <- dmyc$myc[dmyc$cond == "Cancer"]
myc.nc <- dmyc$myc[dmyc$cond == "NC"]
t.test(myc.nc, myc.cancer, paired = TRUE)


## ------------------------------------------------------------------------
dmyc


## ------------------------------------------------------------------------
dmycO <- dmyc[order(dmyc$id, dmyc$cond), ]
dmycO
myc.cancer <- dmycO$myc[dmycO$cond == "Cancer"]
myc.nc <- dmycO$myc[dmycO$cond == "NC"]
t.test(myc.nc, myc.cancer, paired = TRUE)


## ------------------------------------------------------------------------
diff.nc.c <- (myc.nc - myc.cancer)
t.test(diff.nc.c)


## ----fig.width=3.5, fig.height=3.5---------------------------------------
plotMeans(dmyc$myc, dmyc$cond, error.bars = "se", ylab = "MYC",
          xlab = "Condition")


## ----fig.width=3.5, fig.height=3.5, echo=TRUE, fig.show = 'hold'---------
Boxplot( ~ diff.nc.c, xlab = "",
        ylab = "Intra-subject difference (NC - C)", main = "MYC")


## ----fig.show='hold'-----------------------------------------------------
stripchart(myc ~ cond, vertical = TRUE, data = dmyc)
for(i in unique(dmyc$id)) 
  segments(x0 = 1, x1 = 2, 
           y0 = dmyc$myc[dmyc$cond == "Cancer" & dmyc$id == i], 
           y1 = dmyc$myc[dmyc$cond == "NC" & dmyc$id == i], 
           col = "red")


## ------------------------------------------------------------------------
LinearModel.1 <- lm(myc ~ id + cond, data = dmyc)
summary(LinearModel.1)


## ------------------------------------------------------------------------
Anova(LinearModel.1, type = "II")


## ------------------------------------------------------------------------
wilcox.test(p53 ~ cond, alternative = "two.sided", data = dp53)


## ------------------------------------------------------------------------
wilcox.test(myc.nc, myc.cancer, alternative = 'two.sided', paired = TRUE)


## ------------------------------------------------------------------------
wilcox.test(diff.nc.c)


## ------------------------------------------------------------------------
## Without logs
wilcox.test(dmyc$myc[1:12], dmyc$myc[13:24], paired = TRUE)
## After taking logs
wilcox.test(log(dmyc$myc[1:12]), log(dmyc$myc[13:24]), paired = TRUE)


## ----create_brca, echo=FALSE, results='hide'-----------------------------
set.seed(27)
n1 <- 8
n2 <- 5
nn <- 3
s <- rnorm(n1 + n2, 0, 2)
s <- rep(s, rep(nn, n1 + n2))
effect <- 1
cond.effect <- rep(c(0, effect), c(n1 * nn, n2 * nn))
cond <- rep(c("Cancer", "NC"), c(n1 * nn, n2 * nn))
y <- rnorm(length(cond.effect)) + s + cond.effect
y <- y - min(y) + 0.1
id <- replicate(n1 + n2, paste(sample(letters, 10), collapse = ""))
id <- rep(id, rep(nn, n1 + n2))
dbrca <- data.frame(brca2 = round(y, 3), 
                    cond = cond,
                    id = id)
## t.test(brca2 ~ cond, data = dbrca)
## aggbrca2 <- aggregate(dbrca[,c("brca2"), drop=FALSE], by=list(cond=dbrca$cond, 
##   id=dbrca$id), FUN=mean)
## t.test(brca2~cond, alternative='two.sided', conf.level=.95, var.equal=FALSE, 
##   data=aggbrca2)
## summary(aov(brca2 ~ cond + Error(id), data = dbrca))
## t.s <- summary(lmer(brca2 ~ cond + (1|id), data = dbrca))$coefficients[2, 3] ## t-statistic
## t.s
## t.s*t.s ## compare with aov

write.table(dbrca, file = "BRCA2.txt", col.names = TRUE,
            row.names = FALSE, sep = "\t", quote = FALSE)
rm(dbrca)


## ----echo=FALSE, results = 'hide'----------------------------------------
dbrca <- read.table("BRCA2.txt", header = TRUE)


## ------------------------------------------------------------------------
t.test(brca2 ~ cond, data = dbrca)


## ------------------------------------------------------------------------
aggbrca <- aggregate(dbrca[,c("brca2"), drop = FALSE],
                     by = list(cond = dbrca$cond, 
                         id = dbrca$id), FUN = mean)


## ------------------------------------------------------------------------
t.test(brca2 ~ cond, alternative = 'two.sided', conf.level = .95, var.equal = FALSE, 
  data = aggbrca)


## ----create_mit, echo=FALSE, results='hide'------------------------------
set.seed(789)
n1 <- 11
n2 <- 12
n3 <- 23
m <- c(0, 0, 1.3)
activ <- rnorm(n1 + n2 + n3) + rep(m, c(n1, n2, n3))
activ <- activ - min(activ) + 0.2
mit <- data.frame(activ = round(activ, 3),
                  training = rep(c(1, 2, 3), c(n1, n2, n3)),
                  id = 1:(n1 + n2 +n3))
write.table(mit, file = "MIT.txt", col.names = TRUE,
            row.names = FALSE, sep = "\t", quote = FALSE)
rm(list = ls())


## ------------------------------------------------------------------------
dmit <- read.table("MIT.txt", header = TRUE)


## ------------------------------------------------------------------------
dmit$ftraining <- factor(dmit$training, 
                         labels = c('Morning','Lunch','Afternoon'))


## ----results='hide'------------------------------------------------------
Boxplot(activ ~ ftraining, data = dmit, id.method = "y")


## ----results='hide'------------------------------------------------------
AnovaMIT <- aov(activ ~ ftraining, data = dmit)
summary(AnovaMIT)


## ------------------------------------------------------------------------
numSummary(dmit$activ , groups = dmit$ftraining, statistics = c("mean", "sd"))


## ------------------------------------------------------------------------
with(dmit, aggregate(activ, list(Training = ftraining), 
                     function(x) c(mean = mean(x), 
                                   sd = sd(x), 
                                   n = sum(!is.na(x)))
                     ))


## ------------------------------------------------------------------------
with(dmit, by(activ, ftraining, 
              function(x) c(mean = mean(x), 
                             sd = sd(x), 
                             n = sum(!is.na(x)))
              ))


## ----tukey1,fig.cap='Plot of pairwise differences with Tukey contrasts', fig.lp='fig:', fig.width=5,fig.height=5, fig.show='hold', results='hide'----

library(multcomp) ## for glht
## The next two lines carry out the multiple comparisons and the following
## lines plot them
Pairs <- glht(AnovaMIT, linfct = mcp(ftraining = "Tukey"))
summary(Pairs) # pairwise tests
confint(Pairs) # confidence intervals
cld(Pairs) # compact letter display
old.oma <- par(oma = c(0,5,0,0))
plot(confint(Pairs))
par(old.oma) ## restore graphics windows settings


## ----out.width='9cm'-----------------------------------------------------
require(effects)
plot(allEffects(AnovaMIT), ask = FALSE)


## ----create_chol, echo=FALSE, results='hide'-----------------------------

set.seed(45)
n <- c(4, 7, 9, 5, 7, 8)
m <- c(2.1, 1, 2, -.2, 4, 5)
y <- round(unlist(mapply(function(x, y) rnorm(x, y), n, m)), 3)
Drug <- c(rep("A", sum(n[1:3])),
          rep("B", sum(n[4:6])))
Diet <- rep(rep(c("HF", "M1", "M2"), 2), n)
chol <- data.frame(y = y,
                   Drug = Drug,
                   Diet = Diet)
rm(y, n, m, Drug, Diet)
## lm1 <- lm(y ~ Drug * Diet, data = chol)
## lm0 <- lm(y ~ Drug + Diet, data = chol)
## anova(lm1)
## Anova(lm1)
## anova(lm0)
## anova(lm(y ~ Diet + Drug, data = chol))
## Anova(lm0)
write.table(chol, file = "Cholesterol.txt", col.names = TRUE,
            row.names = FALSE, sep = "\t", quote = FALSE)
rm(chol)


## ------------------------------------------------------------------------
dcholest <- read.table("Cholesterol.txt", header = TRUE)



## ------------------------------------------------------------------------
par(mfrow = c(1, 2))
boxplot(y ~ Diet, data = dcholest)
with(dcholest, plotMeans(y, Diet, error.bars = "se", 
  xlab = "Diet", ylab = "Cholesterol reduction"))



## ------------------------------------------------------------------------
summary(aov(y ~ Diet, data = dcholest))
anova(lm(y ~ Diet, data = dcholest))
summary(lm(y ~ Diet, data = dcholest))


## ------------------------------------------------------------------------
with(dcholest, tapply(y, Diet, mean))


## ------------------------------------------------------------------------
means <- with(dcholest, tapply(y, Diet, mean))
means[2] - means[1]
means[3] - means[1]
rm(means) ## let's remove it, so as not the leave
          ## garbage around


## ------------------------------------------------------------------------
p.values <- c(0.001, 0.01, 0.03, 0.05)
adjusted.p.values <- p.adjust(p.values, method = "BH")
cbind(p.values, adjusted.p.values)


## ------------------------------------------------------------------------
## This fits the model. Pay attention to the "*"
cholestanova <- (lm(y ~ Diet * Drug, data = dcholest))
## This shows the ANOVA table. Notice the "Type II"
Anova(cholestanova)

## Now we are shown the 3 by 2 table of means, standard deviations, and number 
## of observations
tapply(dcholest$y, list(Diet = dcholest$Diet, Drug = dcholest$Drug), 
       mean, na.rm =TRUE) # means
tapply(dcholest$y, list(Diet = dcholest$Diet, Drug = dcholest$Drug), 
       sd, na.rm =TRUE) # std. deviations
tapply(dcholest$y, list(Diet = dcholest$Diet, Drug = dcholest$Drug), 
       function(x) sum(!is.na(x))) # counts


## ----out.width='12cm', out.height='12cm'---------------------------------
plot(allEffects(cholestanova), ask = FALSE)


## ----out.width = '8cm', out.height = '8cm'-------------------------------
with(dcholest, interaction.plot(Drug, Diet, y, type = "b"))


## ----out.width='14cm', out.height='14cm'---------------------------------
require(HH)
interaction2wt(y ~ Diet + Drug, data = dcholest)


## ----out.width='8cm', out.height='8cm', fig.show='hold'------------------
boxplot(y ~ Drug * Diet, data = dcholest, col = c("salmon", "gold"))
boxplot(y ~ Diet * Drug, data = dcholest, 
        col = c("salmon", "gold", "lightblue"))


## ------------------------------------------------------------------------
dcholest2 <- subset(dcholest, subset = Diet != "HF")


## ------------------------------------------------------------------------
cholest2anova <- (lm(y ~ Diet*Drug, data = dcholest2))
Anova(cholest2anova)


## ------------------------------------------------------------------------
lm1 <- lm(y ~ Diet + Drug, data = dcholest2)
lm2 <- lm(y ~ Drug + Diet, data = dcholest2)


## ------------------------------------------------------------------------
anova(lm1)
anova(lm2)


## ------------------------------------------------------------------------
Anova(lm1)
Anova(lm2)


## ------------------------------------------------------------------------
set.seed(1)
sex <- factor(rep(c("Male", "Female"), c(20, 20)))
drug <- factor(rep(rep(c("A", "B"), c(10, 10)), 2))
y <- rep(c(10, 13, 12, 16), rep(10, 4))
y <- y + rnorm(length(y), sd = 1.5)
y.data <- data.frame(y, sex, drug)


## ------------------------------------------------------------------------
with(y.data, tapply(y, list(sex, drug), function(x) sum(!is.na(x))))
with(y.data, tapply(y, list(sex, drug), mean))


## ------------------------------------------------------------------------
summary(lm(y ~ sex * drug, data = y.data))


## ------------------------------------------------------------------------
m1 <- lm(y ~ sex + drug, data = y.data)
m2 <- lm(y ~ drug + sex, data = y.data)


## ------------------------------------------------------------------------
msex <- lm(y ~ sex, data = y.data)
mdrug <- lm(y ~ drug, data = y.data)


## ------------------------------------------------------------------------
summary(m1)
summary(m2)


## ------------------------------------------------------------------------
summary(msex)
summary(mdrug)


## ------------------------------------------------------------------------
anova(m1)
anova(m2)


## ------------------------------------------------------------------------
Anova(m1)


## ------------------------------------------------------------------------
anova(msex)
anova(mdrug)


## ----create_anage, echo=FALSE, results='hide'----------------------------
anage_a_r <-  read.table("AnAge_birds_reptiles.txt", 
                         header = TRUE)



## ------------------------------------------------------------------------
anage_a_r$logMetabolicRate <- log(anage_a_r$Metabolic.rate..W.)
anage_a_r$logBodyMass <- log(anage_a_r$Body.mass..g.)
anage_a_r$logLongevity <- log(anage_a_r$Maximum.longevity..yrs.)


## ----create_anage_a, echo=FALSE, results='hide'--------------------------
anage_a <- anage_a_r[anage_a_r$Class == "Aves",]


## ------------------------------------------------------------------------
metab <- lm(Metabolic.rate..W. ~ Body.mass..g., data = anage_a)
summary(metab)


## ----out.width = '10cm', out.height = '10cm', results='hide'-------------
scatterplot(Metabolic.rate..W. ~ Body.mass..g., 
            smooth = TRUE, 
            spread = FALSE,  data = anage_a)


## ----out.width = '12cm', out.height = '12cm'-----------------------------
require(HH)
ci.plot(metab)


## ------------------------------------------------------------------------
metablog <- lm(logMetabolicRate ~ logBodyMass, data = anage_a)
summary(metablog)


## ----fig.width=7, fig.height=7,results='hide'----------------------------

scatterplot(Metabolic.rate..W. ~ Body.mass..g., log = "xy", 
            smooth = TRUE, spread = FALSE, 
            data = anage_a)


## ----fig.width=7, fig.height=7,out.width = '12cm', out.height = '12cm'----
ci.plot(metablog)


## ----echo=FALSE,results='hide'-------------------------------------------
data(cystfibr, package = "ISwR")
cystfibr2 <- cystfibr[, c("pemax", "age", "height", "weight", "sex")]
write.table(cystfibr2, file = "CystFibr2.txt", col.names = TRUE,
            row.names = FALSE, sep = "\t", quote = FALSE)
rm(cystfibr2)
rm(cystfibr)


## ------------------------------------------------------------------------
cystfibr2 <- read.table("CystFibr2.txt", header = TRUE)


## ------------------------------------------------------------------------
mcyst <- lm(pemax ~ age + height + weight, data=cystfibr2)
summary(mcyst)


## ------------------------------------------------------------------------
anova(mcyst)
Anova(mcyst)


## ----results='hide'------------------------------------------------------
scatterplotMatrix( ~ age+height+pemax+weight, smooth = TRUE, 
                  spread = FALSE,  data = cystfibr2)


## ------------------------------------------------------------------------
anova(lm(pemax ~ height + weight + age, data = cystfibr2))


## ------------------------------------------------------------------------
anova(lm(pemax ~ weight + height + age, data = cystfibr2))


## ------------------------------------------------------------------------
cystfibr2$sex <- factor(cystfibr2$sex, labels = c('Male','Female'))


## ------------------------------------------------------------------------
mcyst2 <- lm(pemax ~ age * sex, data = cystfibr2)
summary(mcyst2)


## ----results='hide'------------------------------------------------------
scatterplot(pemax ~ age | sex, smooth = FALSE, data = cystfibr2)


## ------------------------------------------------------------------------
ancova(pemax ~ age * sex, data = cystfibr2)


## ------------------------------------------------------------------------
mcyst3 <- lm(pemax ~ age, data = cystfibr2)
anova(mcyst3, mcyst2)


## ------------------------------------------------------------------------
metab_b_r <- lm(logMetabolicRate ~ logBodyMass * Class, data = anage_a_r)
summary(metab_b_r)


## ------------------------------------------------------------------------
metab_b_r_2 <- lm(logMetabolicRate ~ logBodyMass + Class, data = anage_a_r)
summary(metab_b_r_2)
anova(metab_b_r_2, metab_b_r)


## ----results='hide'------------------------------------------------------
scatterplot(Metabolic.rate..W. ~ Body.mass..g. | Class, 
            log = "xy", smooth = FALSE, data = anage_a_r)


## ----fig.width=7, fig.height=7,echo=TRUE, results='hide'-----------------
ancova(logMetabolicRate ~ logBodyMass * Class, 
                data = anage_a_r)


## ------------------------------------------------------------------------
longev_b_r <- lm(logLongevity ~ logBodyMass * Class, data = anage_a_r)
summary(longev_b_r)


## ----results='hide'------------------------------------------------------
scatterplot(Maximum.longevity..yrs. ~ Body.mass..g. | Class, 
            smooth = FALSE, data = anage_a_r)


## ----echo=TRUE, results='hide'-------------------------------------------
ancova(logLongevity ~ logBodyMass * Class, data = anage_a_r)


## ------------------------------------------------------------------------
longev_b_r_2 <- lm(logLongevity ~ logBodyMass,  data = anage_a_r)
anova(longev_b_r_2, longev_b_r)


## ----fig.show='hold', fig.cap='Model diagnostics for metabolic rate model without log transformation '----
oldpar <- par(mfrow = c(2,2))
plot(metab)
par(oldpar)


## ----fig.show='hold', fig.cap='Model diagnostics for metabolic rate model after log transformation '----
oldpar <- par(mfrow = c(2,2))
plot(metablog)
par(oldpar)


## ------------------------------------------------------------------------
lmMITnofactor <- lm(activ ~ training, data = dmit)
summary(lmMITnofactor)
Anova(lmMITnofactor)


## ----echo=FALSE,results='hide',error=FALSE-------------------------------
options(width = 60)


## ------------------------------------------------------------------------
sessionInfo()


