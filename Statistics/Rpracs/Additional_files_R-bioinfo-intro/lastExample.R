randomdata <- matrix(rnorm(50 * 500), ncol = 50)
class <- factor(c(rep("NC", 20), rep("cancer", 30)))
tmp <- t.test(randomdata[1, ] ~ class)
tmp
attributes(tmp)
tmp$p.value
pvalues <- apply(randomdata, 1, function(x) t.test(x ~ class)$p.value)
hist(pvalues)
order(pvalues)
which(pvalues < 0.05)
sum(pvalues < 0.05)
