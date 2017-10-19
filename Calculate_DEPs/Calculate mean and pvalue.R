data=read.table("../desktop/DCM-RV1.txt",header=TRUE,sep="\t")
dim(data)
for(i in 1:dim(data)[1]){data[i,6]=t.test(data[i,2:5],mu=1)[3]}
head(data)
data$mean=rowMeans(data[,2:5])
head(data)
datasel <- data[data$p.value <0.05 & data$mean >1.3,]
dim(datasel)
datasel
datasel2 <-data[data$p.value <0.05 & data$mean <1/1.3,]
dim(datasel2)
write.table(datasel,file="../desktop/DCM-RV-down.txt",quote = F,row.names = F,sep="\t")
write.table(datasel2,file="../desktop/DCM-RV-up.txt",quote = F,row.names = F,sep="\t")
dataARVC=read.table("../desktop/ARVC-RV1.txt",header = TRUE,sep="\t")
dim(dataARVC)
all <- merge(data,dataARVC,by="Accession",all=F)
dim(all)
for (i in 1:dim(all)[1]){all[i,12]=t.test(all[i,2:5],all[i,8:11])[3]}
head(all)
allsel <- all[all$p.value.1 < 0.05,]
dim(allsel)
write.table(all,file="../desktop/ARVCvsDCM-RV.txt",quote = F,row.names = F,sep="\t")
write.table(allsel,file="../desktop/ARVCvsDCM-RV1.txt",quote = F,row.names = F,sep="\t")