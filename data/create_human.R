library(dplyr)
library(stringr)
library(GGally)
#Week 4 datawrangling

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd)
summary(hd)
dim(hd)

str(gii)
summary(gii)
dim(gii)

colnames(gii)[colnames(gii)=="Gender.Inequality.Index..GII."] <- "GII"
colnames(gii)[colnames(gii)=="Maternal.Mortality.Ratio"] <- "MatMortality"
colnames(gii)[colnames(gii)=="Population.with.Secondary.Education..Female."] <- "Edu2F"
colnames(gii)[colnames(gii)=="Labour.Force.Participation.Rate..Female."] <- "LabF"
colnames(gii)[colnames(gii)=="Percent.Representation.in.Parliament"] <- "ParliamentF"
colnames(gii)[colnames(gii)=="Population.with.Secondary.Education..Male."] <- "Edu2M"
colnames(gii)[colnames(gii)=="Labour.Force.Participation.Rate..Male."] <- "LabM"
colnames(gii)[colnames(gii)=="Adolescent.Birth.Rate"] <- "AdoBirth"

colnames(hd)[colnames(hd)=="Human.Development.Index..HDI."] <- "HDI"
colnames(hd)[colnames(hd)=="Expected.Years.of.Education"] <- "EduExp"
colnames(hd)[colnames(hd)=="Gross.National.Income..GNI..per.Capita"] <- "GNI"
colnames(hd)[colnames(hd)=="Life.Expectancy.at.Birth"] <- "LifeExpectancy"
colnames(hd)[colnames(hd)=="Mean.Years.of.Education"] <- "EducationYears"
colnames(hd)[colnames(hd)=="GNI.per.Capita.Rank.Minus.HDI.Rank"] <- "GNI-HDI"


gii["edu2Ratio"] <- gii["Edu2F"]/gii["Edu2M"]
gii["LabRatio"] <- gii["LabF"]/gii["LabM"]

joined_data <- inner_join(hd, gii, by="Country")

#Week 5 Data wrangling
human <- joined_data

#Make GNI numeric
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()

#Remove columns you don't need
keep <- c("Country", "edu2Ratio", "LabRatio", "LifeExpectancy", "EduExp", "GNI", "MatMortality", "AdoBirth", "ParliamentF")

# select the 'keep' columns
human <- select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human, complete.cases(human))

# last indice we want to keep
last <- nrow(human_) - 7

# choose everything until the last 7 observations
human_ <- human_[1:last, ]

# add countries as rownames
rownames(human_) <- human_$Country

#remove Country
human <- select(human_, -Country)

#Write
write.csv(human, file="~/GitHub/IODS-project/data/human.csv", row.names = TRUE)

test <- read.table("~/GitHub/IODS-project/data/human.csv", header = TRUE, row.names= 1, sep = ",")
head(test)
str(test)
