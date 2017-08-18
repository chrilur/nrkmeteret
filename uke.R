wk <- read.csv("data/ukestreng.csv", stringsAsFactors = FALSE)
siste <- nrow(wk)
siste <- wk[siste,]
siste <- paste("Siste uke:", siste)
cat(siste)