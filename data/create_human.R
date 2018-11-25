hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd)
summary(hd)
dim(hd)

str(gii)
summary(gii)
dim(gii)

colnames(gii)[colnames(gii)=="Gender.Inequality.Index..GII"] <- "GII"
colnames(gii)[colnames(gii)=="Maternal.Mortality.Ratio"] <- "MaternalMortality"
colnames(gii)[colnames(gii)=="Population.with.Secondary.Education..Female."] <- "Edu2F"
colnames(gii)[colnames(gii)=="Labour.Force.Participation.Rate..Female."] <- "LabF"
colnames(gii)[colnames(gii)=="Percent.Representation.in.Parliament"] <- "Parliament"
colnames(gii)[colnames(gii)=="Population.with.Secondary.Education..Male."] <- "Edu2M"
colnames(gii)[colnames(gii)=="Labour.Force.Participation.Rate..Male."] <- "LabM"

colnames(hd)[colnames(hd)=="Human.Development.Index..HDI."] <- "HDI"
colnames(hd)[colnames(hd)=="Expected.Years.of.Education"] <- "EYE"
colnames(hd)[colnames(hd)=="Gross.National.Income..GNI..per.Capita"] <- "GNI"
colnames(hd)[colnames(hd)=="Life.Expectancy.at.Birth"] <- "LifeExpectancy"
colnames(hd)[colnames(hd)=="Mean.Years.of.Education"] <- "EducationYears"
colnames(hd)[colnames(hd)=="GNI.per.Capita.Rank.Minus.HDI.Rank"] <- "GNI-HDI"

gii["edu2Ratio"] <- gii["Edu2F"]/gii["Edu2M"]
gii["LabRatio"] <- gii["LabF"]/gii["LabM"]

joined_data <- inner_join(hd, gii, by="Country")
