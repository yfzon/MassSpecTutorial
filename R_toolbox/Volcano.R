data <- read.table("clipboard",header=T,sep="\t")
data <- as.data.frame(data)
data <- data[,1:9]
for (i in 1:dim(data)[1]){data[i,11] <- t.test(data[i,2:10],mu=1)[3]} # calculate p value
for (i in 1:dim(data)[1]){data[i,12] <- sum(data[i,2:10])/9) # calculate fold change

colnames(data)

#### volcano plot #####
fc=data[,"mean"]
pval=data[,"pvalue"]
plot(log2(fc), -log(pval, 10) ) # without color 
data$color="black"
data$color[ data$pvalue < 0.05 & data$mean < 0.769 ]="blue"
data$color[ data$pvalue < 0.05 & data$mean > 1.300 ]="red"

plot(log2(fc), -log(pval, 10) ,col=data$color, main="Volcano") #cex=0.5 point shrinks 0.5 times, xlab x axis legend
abline(h=-log10(0.05),col="grey",lty=2)
abline(v=log2(1.3),col="grey",lty=2) #draw threshold lines
abline(v=-log2(1.3),col="grey",lty=2)
######Here is the script for adding lines on the plot########
pdf("try_volcano.pdf") # save the image as pdf
plot(log2(fc), -log(pval, 10) ,col=data$color, main="protein profile")
abline(h=1.3,col="red") # set the line at p-value =0.05 
abline(v=c(-0.38,0.38),col="blue") #set the lines at log2(foldchange)=-0.38 and log2(foldchange)=0.38

