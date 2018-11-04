#name: smooshi
#date: 4.11.2018
#description: exersize 2
library(dplyr)

#Load tab delimited file:
data <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt",header = TRUE, sep = "\t")

#Dimensions are 183 rows, 60 columns (183 observations, 60 variables)
dim(data)

#All others are Int observatons, gender is a factor F or M
str(data)

analysis <- data.frame(data$gender, data$Age, data$Attitude, data$Points)
# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(data, one_of(deep_questions))
analysis$Deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(data, one_of(surface_questions))
analysis$Surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(data, one_of(strategic_questions))
analysis$Stra <- rowMeans(strategic_columns)
colnames(analysis) <- c("Gender", "Age", "Attitude", "Points", "Deep", "Surf", "Stra")
  
#Working Director
setwd("~/GitHub/IODS-project")
write.csv(analysis, file="~/GitHub/IODS-project/data/learning2014.csv", row.names = FALSE)

test <- read.table("~/GitHub/IODS-project/data/learning2014.csv", header = TRUE, sep = ",")
head(test)
str(test)
