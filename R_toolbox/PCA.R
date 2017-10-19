rm(list=ls()) #清除之前存的所有数据
data<-read.table("clipboard",header=T)#首先在剪贴板里复制所有的组加上变化ratio，不要accession column
require(graphics)
library(rgl) #安装rgl包，load
data.pr<-princomp(data,cor=TRUE)
summary(data.pr,loading=TRUE)
Comp.1=data.pr$loadings[,1]
Comp.2=data.pr$loadings[,2]
Comp.3=data.pr$loadings[,3]
#plot(Comp.1,Comp.2,col=c('yellow','yellow','yellow','green','green','green'))#二维图 两组，每组三个
plot(Comp.1,Comp.2,col=c('yellow','green','yellow','green'))
plot3d(Comp.1,Comp.2,Comp.3,col=c('red','red','red','red','blue','blue','blue','blue'),type="s",radius=0.025) #radius是球的大小
rgl.postscript("plot1.eps","eps",drawText=FALSE) #保存图像，要研究一下