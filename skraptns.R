setwd("C:\\Users\\n633164\\Documents\\R\\nrkmeter\\nrkmeteret")

library(RCurl)
library(jsonlite)

#Sett uke
dato <- as.character(Sys.Date())
uke <- as.integer(format(as.Date(dato), "%W"))-1

#Skrap data
#urlnett <- paste0('http://tnslistene.no/?metric=uv&list_id=1&year=2016&week=',uke)
#urlmob <- paste0('http://tnslistene.no/?metric=uv&list_id=6&year=2016&week=',uke)
#tnsnett <- getURL(urlnett)
#tnsmob <- getURL(urlmob)

# Funksjon for å skrape data, ett medium i ett datasett i én uke
skrap.data <- function(datasett, medium) {
  url <- paste0('http://tnslistene.no/?metric=uv&list_id=', datasett, '&year=2017&week=',uke)
  data <- getURL(url)
  data <- rensk.data(data)
  data <- get.week(data, medium)
  return(data)
}

#Se etter disse linjene i dataene
btnettref <- '<a href="http://www.bt.no">Bergens Tidende</a>'
banettref <- '<a href="http://www.ba.no">Bergensavisen</a>'
hanettref <- '<a href="http://www.haugesunds-avis.no">Haugesunds Avis</a>'
btmobref <- '<a href="http://mobil.bt.no/bt.mob">Bt Mobil</a>'
bamobref <- '<a href="mobil.ba.no">Bergensavisen Mobil</a>'
hamobref <- '<a href="m.h-avis.no">Haugesundsavis Mobil</a>'

#Funksjon for å renske data
rensk.data <- function(x) {
  tns <- unlist(strsplit(x, split='var all = ', fixed=TRUE))[2]
  tns <- unlist(strsplit(tns, split='\nfunction check_fix_value(a_val)', fixed=TRUE))[1]
  json <- fromJSON(tns)
  tns <- do.call("rbind", json$data)
  tns <- as.data.frame(tns, stringsAsFactors=FALSE)
  return(tns)
}

#Finn unike brukere, brukersesjoner og sidevisninger for ett medium
get.week <- function(datasett, medium) {
  tall <- finn.radnr(datasett, medium)
  funn <- as.integer(c(datasett[[tall]][3], datasett[[tall]][4], datasett[[tall]][5]))
  return(funn)
}

#Hvilken plassering har mediet på listen?
finn.radnr <- function(datasett, ref) {
  medier <- as.character(datasett[2,][1:length(datasett)])
  tall <- which(medier==ref)
  return(tall)
}

#Lag liste for ett medium over i antall uker.
uker <- 1:52
get.medium <- function(datasett, år, medium) {
  frame <- data.frame()
  for (i in uker) {
    uke <- paste0('http://tnslistene.no/?metric=uv&list_id=', datasett, '&year=', år,'&week=', i)
    data <- getURL(uke)
    data <- rensk.data(data)
    funn <- get.week(data, medium)
    frame <- rbind(frame, funn)
    }
  names(frame) <- c("ub", "bs", "sv") 
  return(frame)
}

filer <- c("data/btmob.csv", "data/bamob.csv", "data/hamob.csv", "data/btnett.csv", "data/banett.csv", "data/hanett.csv")
refs <- c(btmobref, bamobref, hamobref, btnettref, banettref, hanettref)
sett <- c(6,6,6,1,1,1)

### Oppdatering av tall fra siste uke
for (i in 1:6) {
  fil <- read.csv(filer[i], stringsAsFactors=FALSE)
  filny <- skrap.data(sett[i], refs[i])
  fil <- rbind(fil, filny)
  write.table(fil, filer[i], sep=",", row.names=FALSE)
}

#Lage data
source("lagedata.R")