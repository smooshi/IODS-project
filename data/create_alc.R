#1-2
#smooshi/Lisa
#UCL Machine Learning Repository, Student Performance Data with Alcohol Consumpion
library(dplyr)

#3
t1=read.table("student-mat.csv",sep=";",header=TRUE)
t2=read.table("student-por.csv",sep=";",header=TRUE)

dim(t1)
dim(t2)
str(t1)
str(t2)

#4
joins <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
t3=merge(t1,t2,by=joins)

dim(t3)
str(t3)

#5
alc <- select(t3, one_of(joins))
not_alc <- colnames(t1)[!colnames(t1) %in% joins]

for (name in not_alc) {
  both <- select(t3, starts_with(name))
  first <- select(both, 1)[[1]]
  if (is.numeric(first)) {
    alc[name] <- round(rowMeans(both))
  } else {
    alc[name] <- first
  }
}

#6
#27 Dalc - workday alcohol consumption (numeric: from 1 - very low to 5 - very high)
#28 Walc - weekend alcohol consumption (numeric: from 1 - very low to 5 - very high) 

alc$alc_use <- (alc$Dalc+alc$Walc)/2
alc$high_use <- alc$alc_use > 2

#7
glimpse(alc)
write.csv(alc, file="~/GitHub/IODS-project/data/alc.csv", row.names = FALSE)

test <- read.table("~/GitHub/IODS-project/data/alc.csv", header = TRUE, sep = ",")
head(test)
str(test)
