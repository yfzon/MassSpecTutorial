library(limma)
rm(list=ls())
data<-read.table("clipboard",header=TRUE)
name<-data[1]
data<-data[2:10]
data$mean=rowMeans(data)
datalog<-log2(data)
datalog$mean=rowMeans(datalog)
hist(data$mean,breaks=20)
hist(datalog$mean,breaks=20)
fit<-lmFit(datalog[1:9])
#Moderate t-statistic
fit<-eBayes(fit)
topTable(fit)
#ordinary t-statistic
ordinary.t<-fit$coef/fit$stdev.unscaled/fit$sigma
#Q-Q plots of t statistics
#Points off the line may be differentially expressed
par(mfrow=c(1,2))
qqt(ordinary.t,df=fit$df.residual,main="Ordinary t")
qqt(fit$t,df=fit$df.total,main="Moderated t")
par(mfrow=c(1,1))
