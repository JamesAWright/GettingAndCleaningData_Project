# Code Book

## The Data Sets

The data used for this project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Reading in the Data Sets

The file containing the data sets was downloaded and manipulated using the run_analysis.R script.
The data sets were split into two main categories:

+ the training data set
+ the test data set
	
Each set is made up of 3 files containing:

+ the measured variables ('X_train.txt' and 'X_test.txt')
+ the activities carried out to obtain data ('y_train.txt' and 'y_test.txt')
+ the subjects that were involved in the experiment ('subject_train.txt' and subject_test.txt')

Additionally, there is a file containing the names of the variables (features) measured ('features.txt').
These features are described in more detail in 'features_info.txt'.
Also, there is a file which maps the activity number in the 'y_train' and 'y_test' to an activity description ('activity_labels.txt')

The three txt files for each data set are read in and combined in a data frame, ready for manipulation.
 

## Cleaning Methods

1. The two data sets are merged (concatenated) 
	+ this is done with the rbind function
2. The columns containing measurements on the mean and standard deviation of each measurement were extracted to produce a reduced data set.
	+ using the grep function to match the strings "mean" or "std" in the measurement labels 
3. The numbered activities in the original data set are named with the character label in the reduced data set.
	+ this was done using a vector lookup 
4. The reduced data set variable (feature) names are replaced with more descriptive names (see following section).
	+ making heavy use of the gsub function
5. Finally, a new data set (data frame) is created, and is made up of the average of each variable
	+ the reduced data set was grouped by subject id and then activity label
	+ a recursive summary function was applied to this grouping (summarise_each)
	

## The Variables

This section is based on the original code book at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain 
signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low 
pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity
 acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 
Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. 
(Note the 'f' to indicate frequency domain signals). 

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

The variables are re-labelled in the final data set, and are preceded with "mean" or "std" along with "time" or "frequency" to denote the domain in which the measurement was taken.

"Subject.ID"                          "Activity.Label"                     
"meanTimeBodyAcc....X"                "meanTimeBodyAcc....Y"               
"meanTimeBodyAcc....Z"                "stdTimeBodyAcc....X"                
"stdTimeBodyAcc....Y"                 "stdTimeBodyAcc....Z"                
"meanTimeGravityAcc....X"             "meanTimeGravityAcc....Y"            
"meanTimeGravityAcc....Z"             "stdTimeGravityAcc....X"             
"stdTimeGravityAcc....Y"              "stdTimeGravityAcc....Z"             
"meanTimeBodyAccJerk....X"            "meanTimeBodyAccJerk....Y"           
"meanTimeBodyAccJerk....Z"            "stdTimeBodyAccJerk....X"            
"stdTimeBodyAccJerk....Y"             "stdTimeBodyAccJerk....Z"            
"meanTimeBodyGyro....X"               "meanTimeBodyGyro....Y"              
"meanTimeBodyGyro....Z"               "stdTimeBodyGyro....X"               
"stdTimeBodyGyro....Y"                "stdTimeBodyGyro....Z"               
"meanTimeBodyGyroJerk....X"           "meanTimeBodyGyroJerk....Y"          
"meanTimeBodyGyroJerk....Z"           "stdTimeBodyGyroJerk....X"           
"stdTimeBodyGyroJerk....Y"            "stdTimeBodyGyroJerk....Z"           
"meanTimeBodyAccMag..."               "stdTimeBodyAccMag..."               
"meanTimeGravityAccMag..."            "stdTimeGravityAccMag..."            
"meanTimeBodyAccJerkMag..."           "stdTimeBodyAccJerkMag..."           
"meanTimeBodyGyroMag..."              "stdTimeBodyGyroMag..."              
"meanTimeBodyGyroJerkMag..."          "stdTimeBodyGyroJerkMag..."          
"meanFrequencyBodyAcc....X"           "meanFrequencyBodyAcc....Y"          
"meanFrequencyBodyAcc....Z"           "stdFrequencyBodyAcc....X"           
"stdFrequencyBodyAcc....Y"            "stdFrequencyBodyAcc....Z"           
"meanFrequencyBodyAccJerk....X"       "meanFrequencyBodyAccJerk....Y"      
"meanFrequencyBodyAccJerk....Z"       "stdFrequencyBodyAccJerk....X"       
"stdFrequencyBodyAccJerk....Y"        "stdFrequencyBodyAccJerk....Z"       
"meanFrequencyBodyGyro....X"          "meanFrequencyBodyGyro....Y"         
"meanFrequencyBodyGyro....Z"          "stdFrequencyBodyGyro....X"          
"stdFrequencyBodyGyro....Y"           "stdFrequencyBodyGyro....Z"          
"meanFrequencyBodyAccMag..."          "stdFrequencyBodyAccMag..."          
"meanFrequencyBodyBodyAccJerkMag..."  "stdFrequencyBodyBodyAccJerkMag..."  
"meanFrequencyBodyBodyGyroMag..."     "stdFrequencyBodyBodyGyroMag..."     
"meanFrequencyBodyBodyGyroJerkMag..." "stdFrequencyBodyBodyGyroJerkMag..."