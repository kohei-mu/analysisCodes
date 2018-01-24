library(data.table)
library(dplyr)

##個別データ対象

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
##全ファイル対象

path <- ''
setwd(path)
files <- list.files(path, pattern=".csv")
for ( file in files){
  #空の行列を作成
  out_ma <- matrix(nrow=length(x), ncol=0)
  file_path <- paste(path, file, sep="")
  df <- read.csv(file_path, header=TRUE)
  for (col in names(df)){
    x <- df[[col]]
    
    #元データをプロット
    plot(x, type="l", main=paste(strsplit(file, "_imp.csv"), paste("original_", col, sep = ""), sep="_"))
    
    #フーリエ変換
    c <- fft(x)
    c_spec <- abs(c/length(x))[2:length(c)]
    graph_name <- paste(strsplit(file, "_imp.csv"), paste("fft_", col, sep = ""), sep="_")
    plot(c_spec, type="l", main=graph_name)
    
    out_ma <- cbind(out_ma, c_spec)
    
    ##ピリオドグラム(周期成分の強さを示す)
    #spec.pgram(x,log="no")
    
    #逆変換
    x_length <- 1:length(x)
    c_inverse <- fft(c, inverse = TRUE) / length(x)
    graph_name2 <- paste(strsplit(file, "_imp.csv"), paste("inversed_fft_", col, sep = ""), sep="_")
    plot(x_length, c_inverse, type="l", main=graph_name2)
  }
  out_df <- as.data.frame(out_ma)
  write.csv(out_df, "", quote=FALSE, row.names=FALSE)
}

