# Assignment Discription
Create one R script called run_analysis.R that does the following:   
1. Merges the training and the test sets to create one data set.   
2. Extracts only the measurements on the mean and standard deviation for each measurement.   
3. Uses descriptive activity names to name the activities in the data set.  
4. Appropriately labels the data set with descriptive activity names.   
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
# Steps 
1. use function read.table() to read data into data set and then use function rbind() to put it together in the format of: subjects, labels, everything else;  
2. use function read.table() read the features and retain features of mean and standard deviation; select only the means and standard deviations from data and increment by 2 because data has subjects and labels in the beginning;
3. read the labels (activities) and replace labels in data with label names;
4. make a list of the current column names and feature names, then tidy that list by removing every non-alphabetic character and converting to lowercase, then use the list as column names for data;
5. use function aggregate() to find the mean for each combination of subject and label；
6. run source("run_analysis.R") , then it will generate a new file tinydata.txt in your working directory.
# How the scripts work
1. download the zip files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. unzip the file to the R working directory
3. save run_analysis.R to the R working directory
4. run source("run_analysis.R") , then it will generate a new file tinydata.txt in your working directory.
