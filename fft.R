library(data.table)
library(dplyr)

##�ʃf�[�^�Ώ�

df <- read.csv("", header=TRUE)

x <- df[["CU_X"]]
plot(x, type="l", main="original")

#spec.pgram(x,log="no")
#spec <- spec.pgram(x,log="no", plot=TRUE)$spec
#freq <- spec.pgram(x,log="no", plot=TRUE)$freq

c <- fft(x)
c_spec <- abs(c/length(x))[2:length(c)]
plot(c_spec, type="l", main="fft")

x_length <- 1:length(x)
c_inverse <- fft(c, inverse = TRUE) / length(x)
plot(x_length, c_inverse, type="l", main="inversed_fft")


########################
##�S�t�@�C���Ώ�

path <- ''
setwd(path)
files <- list.files(path, pattern=".csv")
for ( file in files){
  file_path <- paste(path, file, sep="")
  df <- read.csv(file_path, header=TRUE)
  for (col in names(df)){
    x <- df[[col]]
    
    #���f�[�^���v���b�g
    plot(x, type="l", main=paste(strsplit(file, "_imp.csv"), paste("original_", col, sep = ""), sep="_"))
    
    #�t�[���G�ϊ�
    c <- fft(x)
    c_spec <- abs(c/length(x))[2:length(c)]
    graph_name <- paste(strsplit(file, "_imp.csv"), paste("fft_", col, sep = ""), sep="_")
    plot(c_spec, type="l", main=graph_name)
    
    ##�s���I�h�O����(���������̋���������)
    #spec.pgram(x,log="no")
    
    #�t�ϊ�
    x_length <- 1:length(x)
    c_inverse <- fft(c, inverse = TRUE) / length(x)
    graph_name2 <- paste(strsplit(file, "_imp.csv"), paste("inversed_fft_", col, sep = ""), sep="_")
    plot(x_length, c_inverse, type="l", main=graph_name2)
  }
}
