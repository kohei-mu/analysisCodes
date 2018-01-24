library(xts)
library(data.table)
library(psych)
library(stringr)
library(vegan)
library(dplyr)
library(mice)
library(minerva)

path <- ''
setwd(path)
files <- list.files(path, pattern=".csv")

for ( file in files){
  
  #���̓t�@�C����
  file_path <- paste(path, file, sep="")
  df <- read.csv(file_path, header=TRUE)
  
  #�����l�m�F
  #md.pattern(df)
  
  #�⊮�A���S���Y���m�F
  #methods(mice)
  #�⊮���s
  tempData <- mice(df,
                   m=5, 
                   maxit=20,
                   meth='pmm', 
                   seed=500)
  
  #�⊮���m�F
  #tempData$imp
  #�⊮�f�[�^�ƌ��f�[�^�̕��z���傫���ω����Ă��Ȃ����Ƃ��m�F
  #densityplot(tempData)
  
  #�⊮�f�[�^����
  completedData <- complete(tempData,3)
  #md.pattern(completedData)
  
  #�o�̓t�@�C����
  out_file_tmp <- paste(strsplit(file, ".csv"), "_imp.csv", sep="")
  out_file <- paste(paste(path,'imp/',sep=""), out_file_tmp, sep="")
  #�⊮�ς݃f�[�^���o��
  write.csv(completedData, out_file, quote=FALSE, row.names=FALSE)

}

##���փv���b�g

#�s�A�\���̑��֌W���i�P���j
p <- cor(completedData[,1:ncol(completedData)],method="pearson")
cor.plot(p ,numbers = T,main="pearson",xlas=2,cex.axis=0.75, cex=0.5)

#�X�s�A�}���̑��֌W���i�����j
s <- cor(completedData[,1:ncol(completedData)],method="spearman")
cor.plot(s,numbers = T,main="spearman",xlas=2,cex.axis=0.75, cex=0.5)

#MIC(����`)
m <- mine(completedData[,1:ncol(completedData)])$MIC
cor.plot(m,numbers = T,main="mic",xlas=2,cex.axis=0.75, cex=0.5)




