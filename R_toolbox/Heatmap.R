data <- read.table("clipboard",header=T,sep="\t")
data <- as.data.frame(data)
data <- data[,1:9]
for (i in 1:dim(data)[1]){data[i,11] <- t.test(data[i,2:10],mu=1)[3]} # calculate p value
for (i in 1:dim(data)[1]){data[i,12] <- sum(data[i,2:10])/9) # calculate fold change

colnames(data)
#### heat map ####
matirx(data)
require(ggplot2) 
require(gplots) 
datasel <- data[,2:9]
my_palette <- colorRampPalette(c("green", "black", "red"))(n = 299)
rownames(datasel) <- data$genesymbol
heatmap.2(log2(datasel),col=my_palette,trace="none")   