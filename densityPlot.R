
path <-  ""
setwd(path)
files <- list.files(path, pattern=".csv")
for(file in files){
  file_path <- paste(path, file, sep="")
  df <- read.csv(file_path, header=TRUE)
  
  dens <- apply(df, 2, density, na.remove=TRUE)
  graph_name <- paste(strsplit(file, "_imp.csv"), " density plot", sep="")
  plot(NA, xlim=range(sapply(dens, "[", "x")), ylim=range(sapply(dens, "[", "y")), main=graph_name, ylab="")
  mapply(lines, dens, col=1:length(dens))
  legend("topright", legend=names(dens), fill=1:length(dens))
}


