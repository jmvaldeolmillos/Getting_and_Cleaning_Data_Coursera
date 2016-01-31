# Getting and Cleaning Data Course Project CodeBook
### Assignment Week 4
***
This file describes step by step how the script **run_analysis.R** works. Variables and processing operations to achieve a clean dataset (DataSet Step 4 and 5).

**The site where the data was obtained:**
*Human Activity Recognition Using Smartphones Data Set*
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

**The data for the project:**
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The **run_analysis.R** script works the following steps:
    1. Read X_train.txt, y_train.txt and subject_train.txt from the "data/train" folder and store them in *dataTrain*, *labelTrain* and *subjectTrain* variables.
    2. Read X_test.txt, y_test.txt and subject_test.txt from the "data/test" folder and store them in *dataTest*, *labelTest* and *subjectTest* variables.
    3. With rbin concatenate dataTrain to dataTest to generate *dataJoin* (dimension: 10299x66); concatenate labelTrain to labelTest to generate *labelJoin* (dimension: 10299x1); concatenate subjectTrain to subjectTest to generate *subjectJoin* (dimension: 10299x1).
    4. Read features.txt file from the "data" folder and store the data in a variable *nameVars*. We only need the columns mean and std. We get a subset of dataJoin with 66 columns (all with mean and std columns).
    5. Clean the names of the subset columns. Remove the symbols: "()" and "-" and make the first letter of "mean" and "std" a capital letter "M" and "S" respectively (naming convention).
    6. Read the activity_labels.txt file from the "data" folder and store the data in *activities*.
    7. We cleans the activity names in the second column of activities. 
        * All names to lower cases.
        * I remove the underscore and capitalize the letter after the underscore.
    8. Transform the values of labelJoin according to the activities data frame.
    9. I combined the subjectJoin, labelJoin and dataJoon with cbind to get *newData* (dimension: 10299x68). Properly name the first two columns, "subject" and "typeOfActivity". The "subject" column contains a range of integers from 1 to 30 inclusive (subjects) and "typeOfActivities" column contains the six activity names; the rest of the columns contain measurements (mean and std values).
    10. Write the newData dataset out to **"dataSetStep4.txt"** file in the working directory (also in format csv uncomment the line).
    11. And generate a second cleaned dataset with the average of each measurement for each activity and each subject. With 30 unique subjects and 6 unique activities (total 180 rows and 68 vars.). For this I used the dplyr library. First group the dataset by subject and typeOfActivity and then with summarise_each I applied the average (mean) for each group. Finally write the newData dataset out to **"dataSetStep5.txt"** file in the working directory (also in format csv uncomment the line).