#Valentina Kieseppä
#14.11.2018
#week 3, data wrangling
#Data used is from: "https://archive.ics.uci.edu/ml/machine-learning-databases/00320/"

#Reading the data and exploring its structure and dimensions.

setwd("\\\\helfs01.thl.fi/homes/vkif/_Documents/Uusi kansio/IODS-project/data")

mat <- read.csv("student-mat.csv", sep = ";", header = TRUE)
str(mat)
dim(mat)

por <- read.csv("student-por.csv", sep = ";", header = TRUE)
str(por)
dim(por)


#Joining the data sets and exploring the new data
library(dplyr)
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu",
             "Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(mat, por, by = join_by, suffix = c(".math", ".por"))

dim(math_por)
str(math_por)

#selecting the joined columns
alc <- select(math_por, one_of(join_by))

#the columns which were not used for joining data
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]


#Double answer problem: Take a rounded average if the variables are numeric, if not,
#just choose the first answer
for(column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- first_column
  }
}

#Defining a new column alc_use by combining weekday and weekend alcohol use.
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#Defining column high use
alc <- mutate(alc, high_use = alc_use > 2)

#Saving the modified dataset and checking its in order
write.csv(alc, file = "alc.csv")
TABLE <- read.csv("alc.csv", sep = ",", header = TRUE, row.names = 1)

str(TABLE)

