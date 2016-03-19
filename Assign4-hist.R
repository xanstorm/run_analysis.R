getwd()
setwd("/Users/stephenhobbs1/Desktop/rprog_data_ProgAssignment3-data")
data <- read.csv("outcome-of-care-measures.csv")
str(data)
head(data,10)
colnames(data)
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome) 
outcome[,11] <- as.numeric(outcome[,11]) #changes char (number) to numeric ("1") to 1, if not possible, then NA
hist(outcome[,11])

data <- read.csv("outcome-of-care-measures.csv")
data <- data[,c(2,7,11,13,23)]
data
str(data)
colnames(data)[3:5] <- c("heart attack", "heart failure", "pneumonia")
colnames(data)
