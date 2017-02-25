##Fikse NRK-tall
setwd("C:\\Users\\n633164\\Documents\\R\\nrkmeter\\nrkmeteret")

fiks.nrk <- function(filnavn) {
  navn <- paste0("data/", filnavn)
  fil <- read.csv(navn, stringsAsFactors=FALSE, header=FALSE)
  slutt <- length(fil[,1])
  fil <- fil[1:slutt,]
  fil <- data.frame(cbind(fil[,5], fil[,3], fil[,2]))
  fil <- sapply(fil, function(v) {as.numeric(gsub("\\,","", as.character(v)))})
  fil <- as.data.frame(fil)
  names(fil) <- c("ub", "bs", "sv")
  write.table(fil, navn, sep=",", row.names=FALSE)
}

navn <- "data/dkhonett2.csv"
nett <- read.csv(navn, stringsAsFactors=FALSE)
uke <- nett[1:7,]