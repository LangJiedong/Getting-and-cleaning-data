setwd("/Users/lang/Desktop/coursera/data")

## step 1: download zip file from website
if(!file.exists("./data")) dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/projectData_getCleanData.zip")

## step 2: unzip data
listZip <- unzip("./data/projectData_getCleanData.zip", exdir = "./data")

## step 3: load data into R
x_train=read.table("X_train.txt")
y_train=read.table("y_train.txt")
subject_train=read.table("subject_train.txt")
x_test=read.table("X_test.txt")
y_test=read.table("y_test.txt")
subject_test=read.table("subject_test.txt")

## step 4: merge train and test data
x_data=rbind(x_train, x_test)
y_data=rbind(y_train, y_test)
subject_data=rbind(subject_train, subject_test)

## step 5: load feature name into R
features=read.table("features.txt")
setwd("/Users/lang/Desktop/coursera/data/UCI HAR Dataset")
features=read.table("features.txt")
mean_and_std_features=grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, mean_and_std_features]

## step 6: load activity data into R
activities <- read.table("activity_labels.txt")
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"


names(subject_data) <- "subject"
all_data <- cbind(x_data, y_data, subject_data)
library(plyr)
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "averages_data.txt", row.name=FALSE)

