## Create one R script called run_analysis.R that does the following: 
## 1. Merges the training and the test sets to create one data set. 
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set.
## 4. Appropriately labels the data set with descriptive activity names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Step 1
#  read data into data set
test.labels <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "label")
test.subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test.data <- read.table("./UCI HAR Dataset/test/X_test.txt")
train.labels <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names="label") 
train.subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="subject") 
train.data <- read.table("./UCI HAR Dataset/train/X_train.txt") 
#  put it together in the format of: subjects, labels, everything else 
data <- rbind(cbind(test.subjects, test.labels, test.data),
              cbind(train.subjects, train.labels, train.data)) 

## step 2 
# read the features 
features <- read.table("features.txt", strip.white=TRUE, stringsAsFactors=FALSE) 
# only retain features of mean and standard deviation 
features.mean.std <- features[grep("mean\\(\\)|std\\(\\)", features$V2),] 

# select only the means and standard deviations from data 
# increment by 2 because data has subjects and labels in the beginning 
data.mean.std <- data[, c(1, 2, features.mean.std$V1+2)] 

## step 3 
# read the labels (activities) 
labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE) 
# replace labels in data with label names 
data.mean.std$label <- labels[data.mean.std$label, 2]

## step 4 
# first make a list of the current column names and feature names 
good.colnames <- c("subject", "label", features.mean.std$V2) 
# then tidy that list 
# by removing every non-alphabetic character and converting to lowercase 
good.colnames <- tolower(gsub("[^[:alpha:]]", "", good.colnames)) 
# then use the list as column names for data 
colnames(data.mean.std) <- good.colnames 

## step 5 
# find the mean for each combination of subject and label 
aggr.data <- aggregate(data.mean.std[, 3:ncol(data.mean.std)], 
                       by=list(subject = data.mean.std$subject,
                               label = data.mean.std$label), 
                               mean) 

## write the data for course upload 
write.table(format(aggr.data, scientific=T), "tidydata.txt", 
            row.names=F, col.names=F, quote=2) 
