
path <-  ""
setwd(path)
files <- list.files(path, pattern=".csv")
for(file in files){
  file_path <- paste(path, file, sep="")
  df <- read.csv(file_path, header=TRUE)
  s <- apply(df, 2, sd)
  graph_title <- paste(strsplit(file, "_imp.csv"), "boxplot", sep=" ")
  boxplot(df, main=graph_title, las=2, cex.axis = 0.8)
}


