#Valentina Kieseppä
#6.11.2018
#Data wrangling exercise. Data used is from:
#http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt

#reading the data into R and exploring it's structure and dimensions
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(learning2014)
str(learning2014)

#Data has 183 rows (observations) and 60 columns (variables).

#accessing dlpyr
library(dplyr)

#Combining questions to create variable deep
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

#Combining questions to create variable surf
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

#Combining questions to create variable stra
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(strategic_columns)

#Combining questions to create variable attitude
attitude_questions <- c("Da", "Db", "Dc", "Dd", "De", "Df", "Dg", "Dh", "Di", "Dj")
attitude_columns <- select(learning2014, one_of(attitude_questions))
learning2014$attitude <- rowMeans(attitude_columns)

#creating the dataset
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
new_learning2014 <- select(learning2014, one_of(keep_columns))
final_learning2014 <-  filter(new_learning2014, Points != 0)

#setting the working directory
setwd("\\\\helfs01.thl.fi/homes/vkif/_Documents/Uusi kansio/IODS-project/data")

#saving the analysis into a txt-file and checking that everything is in order.
write.table(final_learning2014, file = "learning2014.txt")
the_table <- read.table("learning2014.txt")
str(the_table)
head(the_table)

                          
