data <- read.table("clipboard",header=T,sep="\t")
data <- as.data.frame(data)
data <- data[,1:9]
for (i in 1:dim(data)[1]){data[i,11] <- t.test(data[i,2:10],mu=1)[3]} # calculate p value
for (i in 1:dim(data)[1]){data[i,12] <- sum(data[i,2:10])/9) # calculate fold change
colnames(data)
##### scattered plot ##### data should only contain 2 collumn with the tittle and no protein name only the mean
x.data = data[, "ARVCRV"] #collumn tittle
y.data = data[, "ARVCLV"] #collumn tittle
plot(log2(x.data),log2(y.data), main = "Log2 expression in ARVCRV vs ARVCLV", xlab="ARVCRV", ylab="ARVCLV", col="blue", cex=0.5) #care the sequence
abline(lm(x.data~y.data))
