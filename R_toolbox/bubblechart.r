# input data
x=data.frame(
group=rep(c("ARVC.RV","ARVC.LV","DCM.RV","DCM.LV"),each=8),
upstream_regulator=rep(c("CEBPA","CEBPB","FOXA2","IGF1","STAT3","PPARG","KLF4","KLF2"),times=4),
z_score=c("2.151","1.908","2.39","2.333","1.072","0.375","-0.751","-1.091","1.792","2.793","2.186","1.889","3.113","0.957","0","0","-1.876","0","-0.44","0","0","0","0.099","-0.059","0","0","0","0.723","0","-0.97","0.062","-0.6"),
p_value=c("0.00000014","0.00000223","0.0000793","0.00145","0.00217","0.00254","0.000252","0.0298","0.0000547","0.000000127","0.0000761","0.0162","0.00187","0.0384","0","0","0.0237","0","0.00618","0","0","0","0.025","0.00515","0","0","0","0.0179","0","0.00535","0.0286","0.0406")
,stringsAsFactors=F)

pvals<-as.numeric(x$p_value)
pvals[pvals==0]<-NA
pval<--log10(pvals)
maxp<-ceiling(max(pval,na.rm=T))
minp<-floor(min(pval,na.rm=T))

zval<-as.numeric(x$z_score)
zval[zval==0]<-NA
maxz<-ceiling(max(zval,na.rm=T))
minz<-floor(min(zval,na.rm=T))
pdf("bubbleChart.pdf")
plot(0,type="n",axes=F,main=NULL,xlab="",ylab="",xlim=c(-0.1,2.1),ylim=c(0,16))

count=0
gene=1
for(i in 1:length(pval)){
	if(gene%%8==1 & gene!=1){
		gene=1
		count=count+1
	}
	if(!is.na(pval[i])){
		rgbCol<-rgb(red=((zval[i]-minz)/(maxz-minz)),green=0,blue=((maxz-zval[i])/(maxz-minz)))
		points(x=count/2,y=seq(2,16,2)[gene],col=rgbCol,cex=((pval[i]-minp)/(maxp-minp))*3+0.5,pch=19)
		gene=gene+1
	}else{
		print(i)
		gene=gene+1
	}
}	

axis(1,at=seq(0,1.5,0.5),labels=c("ARVC.RV","ARVC.LV","DCM.RV","DCM.LV"),line=-1)
axis(2,at=seq(2,16,2),labels=F,line=-1.3)
par(xpd=NA)
for(j in 1:8){
	text(x=-0.25,y=j*2,labels=unique(x[,2])[j])
}

text(x=1.88,y=9.5,labels="Z score")
for(k in seq(minz,maxz,0.1)){
	rect(1.8,10+(k-minz),1.95,10+(k-minz)+0.1,col=rgb(red=((k-minz)/(maxz-minz)),green=0,blue=((maxz-k)/(maxz-minz))),border=NA)
	if(k%%2==0){
		lines(x=c(1.95,1.97),y=c(10+(k-minz)+0.03,10+(k-minz)+0.03))
		text(x=2,y=10+(k-minz)+0.1,labels=k)
	}
}

text(x=1.88,y=7.5,labels=expression(-log[10](italic("P Value"))))
for(p in seq(minp,maxp,1)){
	if((p-minp)%%2==0){
		points(x=1.88,y=(p-minp),cex=((p-minp)/(maxp-minp))*3+0.5,pch=19)
		text(x=2,y=(p-minp),labels=p)
	}
}
dev.off()
