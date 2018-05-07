#install TCGAbiolinks packages run once at first
#Stable version
#source("https://bioconductor.org/biocLite.R")
#biocLite("TCGAbiolinks")
#dev version
#devtools::install_github('BioinformaticsFMRP/TCGAbiolinks')

#start
rm(list=ls())
library(SummarizedExperiment)
library(TCGAbiolinks)
library(dplyr)
version
packageVersion("TCGAbiolinks")

# You can define a list of samples to query and download providing relative TCGA barcodes.

# Query platform Illumina HiSeq with a list of barcode 
query <- GDCquery(project = "TCGA-BRCA", 
                  data.category = "Gene expression",
                  data.type = "Gene expression quantification",
                  experimental.strategy = "RNA-Seq",
                  platform = "Illumina HiSeq",
                  file.type = "results",
                  #barcode = listSamples, 
                  legacy = TRUE)

# Download a list of barcodes with platform IlluminaHiSeq_RNASeqV2
GDCdownload(query)

# Prepare expression matrix with geneID in the rows and samples (barcode) in the columns
# rsem.genes.results as values
BRCARnaseqSE <- GDCprepare(query)

BRCAMatrix <- assay(BRCARnaseqSE,"raw_count") # or BRCAMatrix <- assay(BRCARnaseqSE,"raw_count")

# For gene expression if you need to see a boxplot correlation and AAIC plot to define outliers you can run
BRCARnaseq_CorOutliers <- TCGAanalyze_Preprocessing(BRCARnaseqSE)

# Downstream analysis using gene expression data  
# TCGA samples from IlluminaHiSeq_RNASeqV2 with type rsem.genes.results
save(dataBRCA, geneInfo , file = "dataGeneExpression-BRCA.rda")

# normalization of genes
dataNorm <- TCGAanalyze_Normalization(tabDF = dataBRCA, geneInfo =  geneInfo)

# quantile filter of genes
dataFilt <- TCGAanalyze_Filtering(tabDF = dataNorm,
                                  method = "quantile", 
                                  qnt.cut =  0.25)

# selection of normal samples "NT"
samplesNT <- TCGAquery_SampleTypes(barcode = colnames(dataFilt),
                                   typesample = c("NT"))

# selection of tumor samples "TP"
samplesTP <- TCGAquery_SampleTypes(barcode = colnames(dataFilt), 
                                   typesample = c("TP"))

# Diff.expr.analysis (DEA)
dataDEGs <- TCGAanalyze_DEA(mat1 = dataFilt[,samplesNT],
                            mat2 = dataFilt[,samplesTP],
                            Cond1type = "Normal",
                            Cond2type = "Tumor",
                            fdr.cut = 0.01 ,
                            logFC.cut = 1,
                            method = "glmLRT")

# DEGs table with expression values in normal and tumor samples
dataDEGsFiltLevel <- TCGAanalyze_LevelTab(dataDEGs,"Tumor","Normal",
                                          dataFilt[,samplesTP],dataFilt[,samplesNT])
View(dataDEGsFiltLevel)
write.csv(dataDEGsFiltLevel,file="BRCA_RNAseq.csv")
