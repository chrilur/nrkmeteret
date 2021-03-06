#Lager en js-fil med tall fra TNS Gallup

#skraper TNS for data
#source("skraptns.R")
#Resultat m�lt mot ti siste uker
source("snittall.R")

#Hente inn data
hent.data <- function(x) {
    fil <- paste0("data/", x, ".csv")
    data <- read.csv(fil, header=TRUE, stringsAsFactors=FALSE)
    return(data)
    }
    

#Funksjon for � lage tekststrenger av data
    get.txt <- function(x){
    txt <- character()
    for (i in 1:length(x)) {
            txt <- paste0(txt, x[i], ", ")
            }
            txt <- gsub("\\c\\(", "" ,txt)
            txt <- gsub("\\)", "", txt)
            return(txt)
            }
ukestreng <- read.csv("data/ukestreng.csv", header=FALSE)
denne.uke <- as.integer(paste0(2017,uke))
ukestreng <- rbind(ukestreng, denne.uke)
    
#Klistre sammen javascript-fil som rommer alle data
    # Unike brukere =1, brukersesjoner = 2, sidevisninger = 3
    jsfil <- paste0(
            'var btmobil = { name: ',"'",'BT mobil', "',",' data: [',get.txt(hent.data("btmob")[1]),']};\n\n',
            'var bamobil = { name: ',"'",'BA mobil', "',",' data: [',get.txt(hent.data("bamob")[1]),']};\n\n',
            'var hamobil = { name: ',"'",'HA mobil', "',",' data: [',get.txt(hent.data("hamob")[1]),']};\n\n',
            'var dkhomobil = { name: ',"'",'DKHO mobil', "',",' data: [',get.txt(hent.data("dkhomob")[1]),']};\n\n',
            'var btnett = { name: ',"'",'BT desktop', "',",' data: [',get.txt(hent.data("btnett")[1]),']};\n\n',
            'var banett = { name: ',"'",'BA desktop', "',",' data: [',get.txt(hent.data("banett")[1]),']};\n\n',
            'var hanett = { name: ',"'",'HA desktop', "',",' data: [',get.txt(hent.data("hanett")[1]),']};\n\n',
            'var dkhonett = { name: ',"'",'DKHO desktop', "',",' data: [',get.txt(hent.data("dkhonett")[1]),']};\n\n',
            'var svbtmobil = { name: ',"'",'BT mobil', "',",' data: [',get.txt(hent.data("btmob")[3]),']};\n\n',
            'var svbamobil = { name: ',"'",'BA mobil', "',",' data: [',get.txt(hent.data("bamob")[3]),']};\n\n',
            'var svhamobil = { name: ',"'",'HA mobil', "',",' data: [',get.txt(hent.data("hamob")[3]),']};\n\n',
            'var svdkhomobil = { name: ',"'",'DKHO mobil', "',",' data: [',get.txt(hent.data("dkhomob")[3]),']};\n\n',
            'var svbtnett = { name: ',"'",'BT desktop', "',",' data: [',get.txt(hent.data("btnett")[3]),']};\n\n',
            'var svbanett = { name: ',"'",'BA desktop', "',",' data: [',get.txt(hent.data("banett")[3]),']};\n\n',
            'var svhanett = { name: ',"'",'HA desktop', "',",' data: [',get.txt(hent.data("hanett")[3]),']};\n\n',
            'var svdkhonett = { name: ',"'",'DKHO desktop', "',",' data: [',get.txt(hent.data("dkhonett")[3]),']};\n\n',
            'var snittall = { name: ', "'", 'Endring', "'", ', data: [', snittall, ']};\n\n',
            'var uker = [',get.txt(ukestreng),'];\n\n',
            'var formkurve = [', "'", 'Formkurven - uke ', uke, "'", '];'
            )

#Skriv ut dataene
write.table(jsfil, 'data/data.js', row.names=FALSE, col.names=FALSE, quote=FALSE)
write.table(ukestreng, "data/ukestreng.csv", sep=",", row.names=FALSE, col.names=FALSE, quote=FALSE)