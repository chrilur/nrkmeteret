##Fikse NRK-tall

fiks.nrk <- function(filnavn) {
  navn <- paste0("data/", filnavn)
  fil <- read.csv(navn, stringsAsFactors=FALSE)
  fil <- fil[2:56,]
  fil <- data.frame(cbind(fil[,5], fil[,3], fil[,2]))
  fil <- sapply(fil, function(v) {as.numeric(gsub("\\,","", as.character(v)))})
  fil <- as.data.frame(fil)
  names(fil) <- c("ub", "bs", "sv")
  write.table(fil, navn, sep=",", row.names=FALSE)
}