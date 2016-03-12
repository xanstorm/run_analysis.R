# run_analysis.R
Smartphone fitness analysis
Analyzes smart phone fitness data from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip contains all the data and readme files used 
in conducting an experiment by the researchers.
The code and comments are included at the end of this read.me file as part of the explanation of what the code does, line by line.
The purpose of the task was to combine the subject_id, experiment participant in this case, with the activity, and the time or frequency data gathered from the smartphone. The smartphone collected X, Y, and Z coordinates of the participants' movements. Next,
I presented only the mean and standarard deviation of the X, Y, and Z components of the time and frequency data. This analysis includes mean and standard deviation and omits many of the other variables such as mad, min, max, energy, iqr, entropy, and so on. Whereas the original data contained 561 factor level variables, this analysis contains only 86. The combined test and training data contains 15,480 observations.

The analysis I performed took the data files, comprised of the raw data, user ID's, and activities, combined both test and training 
data files into a single data set, and then summarized them. Below is a sample of the first ten rows of data. 

subject_id activity                                variable        mean

1           1  WALKING    Time Domain Signal of BodyAcc-mean-X  0.27733076

2           1  WALKING    Time Domain Signal of BodyAcc-mean-Y -0.01738382

3           1  WALKING    Time Domain Signal of BodyAcc-mean-Z -0.11114810

4           1  WALKING     Time Domain Signal of BodyAcc-std-X -0.28374026

5           1  WALKING     Time Domain Signal of BodyAcc-std-Y  0.11446134

6           1  WALKING     Time Domain Signal of BodyAcc-std-Z -0.26002790

7           1  WALKING Time Domain Signal of GravityAcc-mean-X  0.93522320

8           1  WALKING Time Domain Signal of GravityAcc-mean-Y -0.28216502

9           1  WALKING Time Domain Signal of GravityAcc-mean-Z -0.06810286

10          1  WALKING  Time Domain Signal of GravityAcc-std-X -0.97660964

In the features.txt file, the file list 561 variables with names such as "tBodyAcc-mean()-X" or "fBodyAcc-mean()-X." I replaced this terminology, t or f, with the words, "Time Domain Signal" for "t"and "Fast Fourier Transform" for "f" for better readability. I left the "X", "Y", and "Z" coordinates since these are potentially meaningful.

1 Merges the training and the test sets to create one data set.
test <- read.table("./test/X_test.txt",header= FALSE, nrow=5)
test
test <- read.table("./test/X_test.txt",header= FALSE) # Read and look at the test data
test
head(test); str(test); dim(test) #Checking data structure and dimensions
test.label <- read.table("./test/y_test.txt", nrow=5)
test.label
test.label <- read.table("./test/y_test.txt", header=FALSE) # Reading table and looking at the y coordinate test data - numbers associated with standing, walking up and down stairs, etc.
head(test.label); str(test.label); dim(test.label) # Looking at data and dimensions 

test.subject <- read.table("./test/subject_test.txt", header = FALSE) # Reading table of participants, their id's.
str(test.subject); dim(test.subject)   # Looking at data structure, dimensions

test.new <- data.frame(subject_id=test.subject[,1], activity=test.label[,1], test)#this names col names "subject_id" and "activity" i.e. walking
str(test.new)
features <- read.table("./features.txt", header=FALSE) # Reads the features.txt file (tBodyAcc-mean()) into the var called features
features
features <- as.character(features[,2]) # chooses 2nd column in features data frame and reads it as character
features
colnames(test.new) <-c("subject_id","activity", features) # Assign names to columns
features
str(test.new)
activity.label <- read.table("./activity_labels.txt", header=FALSE) # Read in "activity_labels.txt" file, (walking, standing, etc.)
str(activity.label)
activity <- as.character(activity.label[,2]) # Make labels characters
test.new$activity <- factor(test.new$activity, levels=1:6, labels=activity) #changes lables 1-6 to names of activity

 Training data - I changed the training data set just like we changed the test data set: subject_id, activities, variables 
 Create data frame composed of data with column names and activites (walking) changed from numbers (1-6).
 We are making the training file so that the columns are subject_id, activity (walking), and 561 columns of features 
setwd("/Users/stephenhobbs1/Desktop/UCI HAR Dataset")
train <- read.table("./train/X_train.txt",header= FALSE, nrow=5) # Read in 1st 5 rows of data, nrow=5
train # Looks at 1st 5 rows of data
train <- read.table("./train/X_train.txt",header= FALSE) #Gets ALL data, not just 1st 5 rows of data. 

head(train); str(train); dim(train) # Looks at the header, structure, and dimensions (X rows by Y columns) of data - X coordinate data, not the Y coordinate
train.label <- read.table("./train/y_train.txt", nrow=5) #Gets (reads) 1st 5 rows of Y coord data
train.label #Looks at 1st 5 rows of Y coord data
train.label <- read.table("./train/y_train.txt", header=FALSE) #Reads all the data, not just 1st 5 rows
head(train.label); str(train.label); dim(train.label) # Looks at header, structure, dimensions (X rows by Y columns) of data

train.subject <- read.table("./train/subject_train.txt", header = FALSE) # Reads the subject training ID data
str(train.subject); dim(train.subject) # Looks at structure and dimensions of data, rows by columns
colnames(train.new) <-c("subject_id","activity", features) # Adds column names to training data
train.new <- data.frame(subject_id=train.subject[,1], activity=train.label[,1], train) #Creates data frame with colums subject_id, activity, and train data
train.new$activity <- factor(train.new$activity, levels=1:6, labels=activity) #changes labels 1,2,3,4,5,6 to names of activity:standing, walking, etc.
colnames(train.new) <-c("subject_id","activity", features)
head(train.new[,1:5]) # Checks layout of 1st 5 columns to be sure columns are named properly
data.comb <-rbind(test.new,train.new) # Combines both test and training data into a single data frame
?grep
library(plyr)
library(reshape2)
2 - extract dataset with measurements like mean and std
col.names <- colnames(data.comb)
index <- grep(pattern="[Mm]ean|[Ss]td", x=col.names) #Looks for pattern Mean or mean and Std or std in columns
index
col.names[index]

data.extract<-data.comb[,c(1,2,index)]
str(data.extract)
4 Change column names to something easily human readable
col.names <- colnames(data.extract)
col.names<-sub(pattern ="^t", replacement="Time Domain Signal of ", x=col.names) #Part of plyr pkg. Replace t with "Time Domain Signal ". Note the space character between Signal and ".
col.names<-sub(pattern="^f", replacement = "Fast Fourier Transform ", x=col.names) #Replace f with "Fast Fourier Transform ". Note the space character between Transform and ".
col.names<-sub(pattern="\\(", replacement ="", x=col.names) #Removes left parenthesis. Note the double back slash.
col.names<-sub(pattern="\\)", replacement ="", x=col.names) #Removes right parenthesis
col.names<-sub(pattern= "^angle", replacement = "Angle of ", x=col.names) # Replace"angle" with "Angle of".
col.names
colnames(data.extract) <- col.names
5 Second tidy data set of mean
data.melt<-melt(data.extract, id.vars = c("subject_id","activity")) #Part of reshape2 pkg.Swaps variables and values columns/rows. See http://www.statmethods.net/management/reshape.html
head(data.melt)
str(data.melt)
data.tidy<-ddply(data.melt,.(subject_id, activity, variable),summarize, mean=mean(value)) # Computes mean of each var for subject and activity

write.table(data.tidy,file="tidy_mean.txt", row.name = FALSE) # Writes data to a text file, removing row names.
