rm(list=ls())
library(clusterProfiler)
library(DOSE)
data1 <- read.table("clipboard",header=T,sep="\t") # variable
data1 <- as.data.frame(data1)
gene_name <- unique(data1$gene_symbol)
geneID <- bitr(gene_name,fromType="SYMBOL", toType="ENTREZID", OrgDb="org.Hs.eg.db")#reg and leg is the entrzID of the DEP use for human
gene_ID <- geneID$ENTREZID     
go_CC <- enrichGO(gene=gene_ID,OrgDb="org.Hs.eg.db",ont="CC",pAdjustMethod="BH",qvalueCutoff=0.05,pvalueCutoff=0.01,readable=TRUE)#readable=true,means whether mapping gene ID to gene name
go_BP <- enrichGO(gene=gene_ID,OrgDb="org.Hs.eg.db",ont="BP",pAdjustMethod="BH",qvalueCutoff=0.05,pvalueCutoff=0.01,readable=TRUE)
go_MF <- enrichGO(gene=gene_ID,OrgDb="org.Hs.eg.db",ont="MF",pAdjustMethod="BH",qvalueCutoff=0.05,pvalueCutoff=0.01,readable=TRUE)

####for rat GO annotation####
geneID <- bitr(gene_name,fromType="SYMBOL", toType="ENTREZID", OrgDb="org.Rn.eg.db")#Rn means the entrzID db for rat
gene_ID <- geneID$ENTREZID     
go_CC <- enrichGO(gene=gene_ID,OrgDb="org.Rn.eg.db",ont="CC",pAdjustMethod="BH",qvalueCutoff=0.05,pvalueCutoff=0.01,readable=TRUE)#readable=true,means whether mapping gene ID to gene name
go_BP <- enrichGO(gene=gene_ID,OrgDb="org.Rn.eg.db",ont="BP",pAdjustMethod="BH",qvalueCutoff=0.05,pvalueCutoff=0.01,readable=TRUE)
go_MF <- enrichGO(gene=gene_ID,OrgDb="org.Rn.eg.db",ont="MF",pAdjustMethod="BH",qvalueCutoff=0.05,pvalueCutoff=0.01,readable=TRUE)
########


sBP <- simplify(go_BP,cutoff=0.7,by="p.adjust", select_fun=min)#by parameter
sCC <- simplify(go_CC,cutoff=0.7,by="p.adjust", select_fun=min)
sMF <- simplify(go_MF,cutoff=0.7,by="p.adjust", select_fun=min)

#make the plots
enrichMap(go_CC,n=20)#see the output results of enrichmap using all and simplified result to choose the better one
enrichMap(go_BP,n=20)
enrichMap(go_MF,n=20)

enrichMap(sCC)
enrichMap(sBP)
enrichMap(sMF)







