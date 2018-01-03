#Lineær regresjon

btmob <- read.csv("data/btmob.csv", stringsAsFactors = FALSE)
btplot <-  ggplot(btmob, aes(ub,sv)) + geom_point(color="blue") + geom_smooth(method = "lm", se = FALSE)
dkhomob <- read.csv("data/dkhomob.csv", stringsAsFactors = FALSE)
dkhoplot <- ggplot(dkhomob, aes(ub,sv)) + geom_point(color="blue") + geom_smooth(method = "lm", se = FALSE)
bamob <- read.csv("data/bamob.csv", stringsAsFactors = FALSE)
baplot <- ggplot(bamob, aes(ub,sv)) + geom_point(color="blue") + geom_smooth(method = "lm", se = FALSE)