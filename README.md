# GettingAndCleaningData_Project
Coursera Data Science course - "Getting and Cleaning Data" module Project

This repo contains only one script: run_analysis.R.

It works in the following way:

- The data sets are downloaded from the following url: 
	
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
	
- The data sets are unzipped and stored
- The .txt files relating to the two data sets (training set and test set) are opened
- A data frame for each data set is created
- The names of the variables observed are assigned to the column headings
- The two data frames are merged (concatenated)
- A new reduced data frame is created which stores only the mean and standard deviation of the measurements from the experiment
- The activity names for the experiment activities are labelled with character labels, which replace the original integer labels
- The names of the variables observed are modified to be more intuitive (more detail can be found in the code book in this repo)
- From the reduced data set, a new data set (data frame) is created, containing the average of each variable for each activity for each subject
- This data set is returned