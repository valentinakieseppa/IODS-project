#Valentina Kieseppä
#22.11.2018
#Week 4 & 5, data wrangling.
#Data source: http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt

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

#Week 5, data wrangling continues:
str(human)
#Human data includes information on human development and gender equality
#of different countries.

#Let's mutate the data a bit to change GNI to numeric
library(stringr)
human <- mutate(human, GNI = str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric)
str(human$GNI)

#Excluding some of the variables
keep <- c("Country", "Education_ratio", "Labour_ratio", "Life", "Expected_education", 
          "GNI", "Maternal_mortality", "Adolescent_Births", "Parliament_seats")
human <- select(human, one_of(keep))


#Filter out the observations with missing values
data.frame(human[-1], comp = complete.cases(human))
human_ <- filter(human, complete.cases(human))

#Let's remove those regions from the data (the last 7 observations)
last <- nrow(human_) - 7
human_ <- human_[1:last,]

#Adding countries as row names
rownames(human_) <- human_$Country

#and finally removing the country variable from the data
human_ <- select(human_, -Country)


#Saving it
setwd("\\\\helfs01.thl.fi/homes/vkif/_Documents/Uusi kansio/IODS-project/data")
write.csv(human_, file = "human.csv")
TABLE <- read.csv("human.csv", header = TRUE, row.names = 1)
str(TABLE)
