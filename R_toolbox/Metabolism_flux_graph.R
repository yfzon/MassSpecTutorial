library(reshape2)
library(ggplot2)
setwd("D:/BaiduYunDownload/01_科研工作/03_Machine learning in proteomics/Metabolism")
rm(list=ls())
table=read.csv("786-QE-GLN-pos-final.csv",header=T,sep=";") 
compoundlist=colnames(table)
compound=table[,"Compound"]
for(i in 1:length(compound)){
  compoundname=as.character(compound[i]) 
  A=strsplit(compoundname, "\\*")
  formula=unlist(A)[2]
  B=unlist(strsplit(formula,""))[1]   
  com=NULL
  if(B!='m') #It is the first in such chemical
  { 
    com=unlist(A)[1]
    j=i  
    kn=NULL 
    nc=NULL 
    labeling=NULL 
    while(unlist(strsplit(as.character(compound[j]),"\\*"))[1]==com)
      { 
        labeling=append(labeling,unlist(strsplit(as.character(compound[j]),"\\*"))[2],after=length(labeling))
        kn=append(kn,table[,"avrage.kn"][j],after=length(kn))
        nc=append(nc,table[,"avrage.nc"][j],after=length(nc))
        j=j+1
      }
    labeling[1]='m0'
    picdata=data.frame(com=labeling,HSP60.NC=nc,HSP60.KN=kn)
    picdata=melt(picdata,id.vars = "com",varible.name="type",value.name = "abundance")
    pic=ggplot(picdata,aes(com,abundance,fill=variable))+geom_bar(stat="identity",position="dodge")+labs(y='Intensity',title=com)
    savename=gsub("/", "_", com, fixed = TRUE)
    file=paste(savename,".jpg",sep='')
    ggsave(sprintf(file),pic,dpi=1200)
  }
}

