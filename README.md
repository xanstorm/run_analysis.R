# run_analysis.R
Smartphone fitness analysis
Analyzes smart phone fitness data from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip contains all the data and readme files used 
in conducting an experiment by the researchers.

The code and comments are part of the run_analysis.R file, line by line.

The goal of the task was to combine the subject_test, experiment participant in this case, with the activity, and the time or frequency data gathered from the smartphone. The smartphone collected X, Y, and Z coordinates of the participants' movements. Next,
I presented only the mean and standarard deviation of the X, Y, and Z components of the time and frequency data. This analysis includes mean and standard deviation and omits many of the other variables such as mad, min, max, energy, iqr, entropy, and so on. Whereas the original data contained 561 factor level variables, this analysis contains only 86. The combined test and training data contains 15,480 observations.

Data files I used were:

features.txt - List of 561 variables the phones collectd data on. Ex: tBodyAcc-mean()-X

activity_labels.txt - List of activities that were measured. Ex: walking, walking_upstairs

test and training both had the same kinds of data.

subject_test.txt identified the participants by a number. Ex: 2

X_test.txt is the raw data. Ex:   2.5717778e-001 

y_test.txt is the number given to the activity name. Ex: 1. 1 correspesonds to walking; 2 corresponds to walking_upstairs

The analysis I performed took the data files, comprised of the raw data, user ID's, and activities, combined both test and training 
data files into a single data set, and then summarized them. Below is a sample of the first ten rows of data. 

subject_id     activity             variable                       mean

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

In the features.txt file, the file lists 561 variables with names such as "tBodyAcc-mean()-X" or "fBodyAcc-mean()-X." I replaced this terminology, t or f, with the words, "Time Domain Signal" for "t"and "Fast Fourier Transform" for "f" for better readability. I left the "X", "Y", and "Z" coordinates since these are potentially meaningful.

How the code works - Perform the following steps to combine files for both test and training data

Read.table used to read table of test data, X_test.txt

Read.table used to read the test data, y_test.txt

Read.table used to read the test data, subject_test.txt

Create a dataframe naming columns "subject_id" and "activity" and the X test data.

Read.table used to read the test data, features.txt file.

Read.table used to read the test data, activity_labels.txt.

Assign an activity label to the y variable.

Use rbind to combine both test and training data into one dataframe.

Load plyr to use grep function. grep finds letter/number patterns so they can be replaced or isolated. I created an index with only mean and std.

Then I extracted just the data with only mean and std, subject_id, activity, and data from the entire data set.

I renamed variables so they would be easy to read and omitted parenthses. Ex. tBodyAcc-mean()-X became Time Domain Signal-mean-X.

I loaded reshape2 so I could place the variables, Time Domain Signal-mean-X, and mean in a column instead of a row for easy readability.

I then wrote the file to a text file using write.table.

See the file with comments in the code file. 




