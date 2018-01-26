### Objectives
# You will be required to submit: 
# 1) a tidy data set as described below, 
# 2) a link to a Github repository with your script for performing the analysis, and 
# 3) a code book that describes the variables, the data, and any transformations or work 
#   that you performed to clean up the data called CodeBook.md. 
# You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.

# 1) You should create one R script called run_analysis.R that does the following. 
# 2) Merges the training and the test sets to create one data set. 
# 3) Extracts only the measurements on the mean and standard deviation for each measurement.
# 4) Uses descriptive activity names to name the activities in the data set 
# 5) Appropriately labels the data set with descriptive variable names. 
# 6) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# 'features_info.txt': Shows information about the variables used on the feature vector.

# 'features.txt': List of all features.

# 'activity_labels.txt': Links the class labels with their activity name.

# 'train/X_train.txt': Training set.

# 'train/y_train.txt': Training labels.

# 'test/X_test.txt': Test set.

# 'test/y_test.txt': Test labels.


# Import the dplyr library
library(dplyr)
# Import the tidyr library
library(tidyr)
# Import the data.table library
library(data.table)

# input and process activity_labels.txt
# activityLabels<-read.table("./UCI HAR Dataset/activity_labels.txt")
# Read in the activity labels dataset
activity.labels <- read.csv("UCI HAR Dataset/activity_labels.txt", 
                            sep="", header=FALSE)
names(activity.labels)<-c("activityCode","activityDescription")

# Read in the measurement labels dataset
features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features <- select(features,"feature" = V2)

# setup for loop
i<-1
featureLabels<-character()
for(i in i:nrow(features)) {
        featureLabels<-rbind(featureLabels,gsub(" ","",(as.character(features[i,]))))
        i<-i+1
}
remove(i)

# load training data set
# then merge with activityLabels
# then add a new column with text label for each numeric label


# Read the Y training labels.
y.train <- read.csv("UCI HAR Dataset/train/y_train.txt", sep="",
                    header=FALSE)
names(y.train) <-"activityCode"
y.train<-merge(y.train,activity.labels,by.x="activityCode",by.y="activityCode")


# load test data set
# then merge with activityLabels
# then add a new column with text label for each numeric label
y.test<- read.csv("UCI HAR Dataset/test/y_test.txt", sep="",
                  header=FALSE) 
names(y.test)<-"activityCode"
y.test<-merge(y.test,activity.labels,by.x="activityCode",by.y="activityCode")



# Read the X training dataset
# load X training data and label it with names from featureLabels
x.train <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="",
                    header=FALSE)
names(x.train)<-featureLabels

# load X testing data and label it with names from featureLabels
x.test <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="",
                 header=FALSE) 
names(x.test)<-featureLabels
 

###


### now, merge merge test->test data and train->train data (subject_*, X_*, y_*)
## need to get subject.test and subject.train

# Read the training subject datasets
subject.train <- read.csv("UCI HAR Dataset/train/subject_train.txt",
                          sep="", header=FALSE)
names(subject.train)<-"subject"

# Read the test subject dataset
subject.test <- read.csv("UCI HAR Dataset/test/subject_test.txt",
                          sep="", header=FALSE)
names(subject.test)<-"subject"

# merge testing data (subject.test,x.test,y.test) on row number (yikes)
test<-cbind(subject.test,x.test,y.test)
# merge training data
train<-cbind(subject.train,x.train,y.train)

# Combine the training and test running datasets
### append train and test together
# first, add a var in each for where it came from
test$TestData<-TRUE
train$TestData<-FALSE
# now, append train and test
run.data<-rbind(test,train)
###

# Remove the files we don't need anymore from
# the environment.
remove(subject.test, x.test, y.test, subject.train,
       x.train, y.train, test, train)



# Extracts only the measurements on the mean and standard deviation for each measurement.
# run.data <- select( run.data, contains("subject") , contains("activity"), contains("TestData"), contains("mean"),contains("std"))
targetCols<-grep("(-mean|-std)",colnames(run.data))
# now just get subjectcol, activity columns, and targetColumns:
run.data<-run.data[,c(1,563,564,565,targetCols)]
# 1 = "subject", 563 = "activityCode", 564 = "activityDescription", 565 = "testData"
###




# Clean up the column names. Remove parantheses and hyphens
# from column names, both of which are invalid characters in
# column names. Also fix a set of columns that repeat the
# word "Body".
setnames(run.data, colnames(run.data), gsub("\\(\\)", "", colnames(run.data)))
setnames(run.data, colnames(run.data), gsub("-", "_", colnames(run.data)))
setnames(run.data, colnames(run.data), gsub("BodyBody", "Body", colnames(run.data)))
setnames(run.data, colnames(run.data), gsub("^f", "force_", colnames(run.data)))
setnames(run.data, colnames(run.data), gsub("^t", "time_", colnames(run.data)))
setnames(run.data, colnames(run.data), gsub("^std", "standardDeviation", colnames(run.data)))
setnames(run.data, colnames(run.data), gsub("x$", "Xaxis", colnames(run.data)))
setnames(run.data, colnames(run.data), gsub("y$", "Yaxis", colnames(run.data)))
setnames(run.data, colnames(run.data), gsub("z$", "Zaxis", colnames(run.data)))
setnames(run.data, colnames(run.data), gsub("Acc", "Acceleration", colnames(run.data)))
setnames(run.data, colnames(run.data), gsub("Mag", "Magnitude", colnames(run.data)))
setnames(run.data, colnames(run.data), gsub("meanFreq", "meanFrequency", colnames(run.data)))



# Group the running data by subject and activity, then
# calculate the mean of every measurement.
run.data.summary <- run.data %>% select(-contains("activityCode"), -contains("TestData")) %>%
        group_by(subject, activityDescription) %>%
        summarise_all(funs(mean))




# remove unwanted tables and interim data
remove(activity.labels)
remove(targetCols,featureLabels,features)



write.table(run.data.summary, file="tidyData.txt", row.name=FALSE)


