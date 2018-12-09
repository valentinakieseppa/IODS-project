#Valentina Kieseppä
#4.12.2018
#Data wrangling, week 6

library(dplyr)
library(tidyr)


#Loading the dataset BPRS and exploring it
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt",
                   sep  =" ", header = T)
str(BPRS)
summary(BPRS)

#The BPRS data includes 40 obseravtions of 11 variables.The variables include
#treatment, which can be either 1 or 2, and subject number, which ranges from 1-20.
#(Each number appears twice, for both treatments). Data also includes information
#on BPRS scores on weeks from 0-8, each given as a separate variable.

#Loading the dataset RATS and exploring it
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt",
                   header = TRUE, sep = '\t')

str(RATS)
summary(RATS)
head(RATS)

#The RATS data includes 16 observations of 13 variables. The variables inlcude
#ID, which is different for every rat and tha ranges from 1-16, and group,
#which defines wheter the rat belongs to group 1, 2 or 3. The other 11 WD variables
#measure rats' body weights measured weekly.

#Let's make the categorical variables factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


#Converting the BPRS data to a long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group)

#Adding a week variable to BPRS and a time variable to RATSL
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5,5)))
RATSL <- RATSL %>% mutate(Time = as.integer(substr(WD,3,4)))

str(BPRSL)
head(BPRSL)
summary(BPRSL)

#The BPRSL has now 360 observations of 5 variables. Data on it's wide form had
#40 observations, and there were 9 week variables measuring scores on BPRS on 
#each weeks. Now, each measurement of all these 40 subjects on 9 weeks are counted
#as separate observations (9*40=360), and the data inlcudes a new bprs variable
#which measures the bprs score on each occasion. The data inlcudes also a new variable
#week, which measures the specific week in question.

str(RATSL)
head(RATSL)
summary(RATSL)

#The RATSL has now 176 observations of 5 variables.Instead of having eleven seperate variables
#measuring weight on each weekly weighting, we now have variables weight and time, 
#and each weighting is counted as a new observation (16*11=176).


#Saving it
setwd("\\\\helfs01.thl.fi/homes/vkif/_Documents/Uusi kansio/IODS-project/data")
write.csv(RATSL, file = "RATSL.csv")
TABLE1 <- read.csv("RATSL.csv", header = TRUE)
str(TABLE1)

write.csv(BPRSL, file = "BPRSL.csv")
TABLE2 <- read.csv("BPRSL.csv", header = TRUE, row.names = 1)
str(TABLE2)
