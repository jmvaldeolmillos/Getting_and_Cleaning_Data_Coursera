# Getting and Cleaning Data Course Project CodeBook  
### Assignment Week 4  
***
This file describes step by step how the script **run_analysis.R** works. Variables and processing operations to achieve a clean dataset (DataSet Step 4 and 5).  

**The site where the data was obtained:**
*Human Activity Recognition Using Smartphones Data Set*
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

**The data for the project:**
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

**Variables:**  
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean: Mean value
std: Standard deviation

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
