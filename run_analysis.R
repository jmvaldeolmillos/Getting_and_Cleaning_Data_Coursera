# Assignment week 4 - Getting and Cleaning Data
# Author: José Manuel Valdeolmillos Abella.
# System: Ubuntu 15.04 / R-3.2.3 / RStudio 0.99.491

#library
library(dplyr)

# Exists "data" directory??
if (!file.exists("data")){
    dir.create("data")
}
### Step 1: Merges the training and the test sets to create one data set.

# read dataset train: X_train.txt, Y_train.txt and subject_train.txt
# First Train because the subject begin in 1.

dataTrain <- read.table("data/train/X_train.txt")
labelTrain <- read.table("data/train/y_train.txt")
subjectTrain <- read.table("data/train/subject_train.txt")
# equal nrows?
dim(dataTrain)
dim(labelTrain)
dim(subjectTrain)

# read dataset test: X_test.txt, Y_test.txt and subject_test.txt
dataTest <- read.table("data/test/X_test.txt")
labelTest <- read.table("data/test/y_test.txt")
subjectTest <- read.table("data/test/subject_test.txt")
# equal nrows?
dim(dataTest)
dim(labelTest)
dim(subjectTest)

# Join Train and Test by rows
dataJoin <- rbind(dataTrain, dataTest)
labelJoin <- rbind(labelTrain, labelTest)
subjectJoin <- rbind(subjectTrain,subjectTest)

# Read and store the name of vars from features.txt

nameVars <- read.table("data/features.txt")

# Measurements on the mean and stardard deviation
indices <- grep("mean\\(\\)|std\\(\\)", nameVars$V2)
dataJoin <- dataJoin[,indices]

# column names of dataJoin
names(dataJoin)<- nameVars[indices,2]
names(dataJoin)<- gsub("mean","Mean", names(dataJoin))
names(dataJoin)<- gsub("std","Std", names(dataJoin))
names(dataJoin)<- gsub("\\(\\)","", names(dataJoin))
names(dataJoin)<- gsub("-","", names(dataJoin))

# Uses descriptive activity names to name the activities in the data set
activities <- read.table("data/activity_labels.txt")
#similar name convention (not underscore and capitalized)
activities$V2 <- tolower(activities$V2)
activities$V2<-gsub("_u", "U", activities$V2)
activities$V2<-gsub("_d", "D", activities$V2)
# labelJoin with activity names.
colnames(labelJoin) <- "typeOfActivity"
tempLabel <- activities[labelJoin[,1],2]
labelJoin$typeOfActivity <- tempLabel

# Appropriately labels the data set with descriptive variable names.
colnames(subjectJoin) <- "subject"
newData <- cbind(subjectJoin,labelJoin,dataJoin)
# write.csv(newData, "dataSetStep4.csv")
write.table(newData, "dataSetStep4.txt")
dim(newData)
# in RStudio
# View(newData)

# From the data set in step 4, creates a second, independent tidy 
# data set with the average of each variable for each activity and each subject.
newData2 <- group_by(newData, subject, typeOfActivity)
newData3 <- summarise_each(newData2, funs(mean))
# write.csv(newData3, "dataSetStep5.csv")
write.table(newData3, "dataSetStep5.txt")
dim(newData3)
# in RStudio
# View(newData3)