#Valentina Kieseppä
#22.11.2018
#Week 4, data wrangling.

library(dplyr)

#Reading the data into R
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv",
               stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv",
                stringsAsFactors = F, na.strings = "..")

#Exploring the dataset hd
str(hd)
head(hd)
summary (hd)

#Hd includes 8 variables and 195 observations (countries). The variables measure HD-index of different
#countries,their HDI-ranking and variables related to HDI, such as life expectancy, education 
#and gross national income.

#Exploring the dataset gii
str(gii)
summary(gii)

#Gii inlcudes 10 variables and 195 observations (countries). It measures the gender inequality
#index for different countries, and inlcudes variables which measure different aspects related to
#this index and ranking between different countries.

#Renaming the variables
colnames(hd)
names(hd) <- c("Ranking_HDI", "Country", "HDI", "Life", "Expected_education", "Mean_education",
               "GNI", "GNI-HDI")
colnames(gii)
names(gii) <- c("Ranking_GII", "Country", "GII", "Maternal_mortality", "Adolescent_Births", 
                "Parliament_seats", "Secondary_education_F", "Secondary_education_M",
                "Labour_force_F", "Labour_force_M")

#Calculating the ratios between men and women who have secondary education and adding them to the gender inequality data:
gii <- mutate(gii, Education_ratio = (gii$Secondary_education_F / gii$Secondary_education_M))
str(gii)
#The same with participation in labour force:
gii <- mutate(gii, Labour_ratio = gii$Labour_force_F / gii$Labour_force_M)
str(gii)

#Joining of the data sets

human <- inner_join(hd, gii, by = "Country")
str(human)
head(human)

#Saving the modified dataset and checking its in order
setwd("\\\\helfs01.thl.fi/homes/vkif/_Documents/Uusi kansio/IODS-project/data")
write.csv(human, file = "human.csv")
TABLE <- read.csv("human.csv", header = TRUE, row.names = 1)
str(TABLE)

str(TABLE)
head(TABLE)