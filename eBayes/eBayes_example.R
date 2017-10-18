library(limma)
library(edgeR)
rm(list=ls())
#simulate gene expression data,
#6 microarrays and 100 genes with 1 gene differentially expressed
set.seed(2004)
invisible(runif(100))
M<-matrix(rnorm(100*6,sd=0.3),100,6)
M[1,]<-M[1,]+1 #first row +1 modify row[1] as the DEG
fit<-lmFit(M)

#Moderate t-statistic
bfit<-eBayes(fit)
topTable(bfit)

adj.P.Val=bfit$F.p.value

#ordinary t-statistic
ordinary.t<-bfit$coef/bfit$stdev.unscaled/bfit$sigma

#Q-Q plots of t statistics
#Points off the line may be differentially expressed
par(mfrow=c(1,2))
qqt(ordinary.t,df=bfit$df.residual,main="Ordinary t")
abline(0,1)
qqt(bfit$t,df=bfit$df.total,main="Moderated t")
abline(0,1)
par(mfrow=c(1,1))
