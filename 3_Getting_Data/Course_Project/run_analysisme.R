##Getting Data Course Project
##
##Author: Scott Lin

##Purpose of this script is to make a tidy dataset from the Samsung wearable computing dataset.
##I will be breaking up this into the five questions.

library(dplyr)

##1. Merges the training and the test sets to create one data set.
#First thing here is to load the datasets

testsubject <- read.table("./3_Getting_Data/Course_Project/UCI HAR Dataset/test/subject_test.txt")
testdata <- read.table("./3_Getting_Data/Course_Project/UCI HAR Dataset/test/X_test.txt")
testlabel <- read.table("./3_Getting_Data/Course_Project/UCI HAR Dataset/test/Y_test.txt")

combinedtest <- cbind(subject = testsubject, label = testlabel, group = "test", data = testdata)

trainsubject <- read.table("./3_Getting_Data/Course_Project/UCI HAR Dataset/train/subject_train.txt")
traindata <- read.table("./3_Getting_Data/Course_Project/UCI HAR Dataset/train/X_train.txt")
trainlabel <- read.table("./3_Getting_Data/Course_Project/UCI HAR Dataset/train/Y_train.txt")

combinedtrain <- cbind(subject = trainsubject, label = trainlabel, group = "train", data = traindata)

data <- rbind(combinedtrain, combinedtest)

##2. Extracts only the measurements on the mean and standard deviation for each measurement. 

colnm <- as.character(read.table("./3_Getting_Data/Course_Project/UCI HAR Dataset/features.txt")[,2])
datanm <- c("subject",  "label", "group", colnm)
names(data) <- datanm

#Make sure there are unique datanames
names(data) <- make.names(names(data), unique=TRUE)

#Select columns of means and sd, must end with mean and std and not have it in the name
meandf <- select(data, contains("mean..", ignore.case=FALSE)) 
sddf <- select(data, contains("std..", ignore.case=FALSE))

#Remake the data dataframe
data2 <- cbind(data[1:3], meandf, sddf)

##3. Uses descriptive activity names to name the activities in the data set

actlabels <- read.table("./3_Getting_Data/Course_Project/UCI HAR Dataset/activity_labels.txt")
names(actlabels) = c("id", "activity")

data2$label <- with(actlabels, activity[match(data2$label, id)]) ##replaces label
data3 <- rename(data2, activity = label)

##4. Appropriately labels the data set with descriptive variable names. 

#final manipulation, renaming to finaldata
finaldata<-data3

#Remove weird periods
names(finaldata) <- gsub("...",".", names(data3), fixed = TRUE)
names(finaldata) <- gsub("..","", names(finaldata), fixed = TRUE)

#Previous make.names function already removed all parenthesis and dashes so the data is clean.

##5. From the data set in step 4, creates a second, independent tidy data set with the average 
##   of each variable for each activity and each subject.

##Group by subject and activity and group
groupdata <- group_by(finaldata, subject, activity, group)
tidydata <- summarise_each(groupdata, funs(mean))

##6 Output
write.table(tidydata, row.names=FALSE, file = "./3_Getting_Data/Course_Project/tidydata.txt")
