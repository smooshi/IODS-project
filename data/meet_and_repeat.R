#Libraries
library(dplyr)
library(tidyr)

#Load
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep=" ", header=T)
rats <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep="\t", header=T)

dim(BPRS)
str(BPRS)
summary(BPRS)

dim(rats)
str(rats)
summary(rats)

#Factorize
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
rats$Group <- factor(rats$Group)
rats$ID <- factor(rats$ID)

#Long
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
#Extract week/wd
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

ratsL <-  rats %>% gather(key = WD, value = Weight, -ID, -Group)  %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

str(BPRSL)
str(ratsL)

summary(BPRSL)
summary(ratsL)

#write
write.csv(ratsL, file="~/GitHub/IODS-project/data/rats.csv", row.names = TRUE)

test <- read.table("~/GitHub/IODS-project/data/rats.csv", header = TRUE, row.names= 1, sep = ",")
head(test)
str(test)

write.csv(BPRSL, file="~/GitHub/IODS-project/data/bprs.csv", row.names = TRUE)

test <- read.table("~/GitHub/IODS-project/data/bprs.csv", header = TRUE, row.names= 1, sep = ",")
head(test)
str(test)

