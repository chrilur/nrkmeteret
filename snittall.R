##Statistikk for utvikling av unike brukere sammenliknet
##med gjennomsnitt for siste ti år.
#setwd("C:\\Users\\n633164\\Documents\\R\\nrkmeter\\nrkmeteret")

finn.snitt <- function(datasett) {
  fil <- paste0("data/", datasett, ".csv")
  tall <- read.csv(fil, stringsAsFactors=FALSE)
  siste <- nrow(tall)
  snitt <- mean(tall[(siste-10):(siste-1),1])
  res <- round(100*tall[siste,1]/snitt, digits=1)-100
  return(res)
  }

files <- c("dkhonett", "dkhomob", "btnett", "btmob", "banett", "bamob", "hanett", "hamob")

  snittall <- character()

for (i in files) {
  tall <- round(finn.snitt(i), digits=1)
  snittall <- paste0(snittall, tall, ", ")
}
snittall <- gsub('.{2}$', '', snittall)
  
jsfil2 <- paste0(
      'var snittall = { name: ', "'", 'Endring', "'", ', data: [', snittall, ']};')