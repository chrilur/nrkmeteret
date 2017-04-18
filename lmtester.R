### lineær regresjon

#Laste to datasett og slå dem sammen

data <- function(x,y) {
  fil1 <- paste0("data/", x, ".csv")
  fil2 <- paste0("data/", y, ".csv")
  df1 <- read.csv(fil1, stringsAsFactors = FALSE)
  df2 <- read.csv(fil2, stringsAsFactors = FALSE)
  df <- cbind(df1, df2)
  names(df) <- c("ub1", "bs1", "sv1", "ub2", "bs2", "sv2")
  return(df)
}

nrktest <- ggplot(nrk, aes(x=ub1, y=ub2)) + geom_point() + stat_smooth(method = "lm", col = "red")