
run_analysis <- function(){
        
        ### Download data set
        urL <- paste("https://d396qusza40orc.cloudfront.net/",
                     "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                     sep="")
        
        destFile <- 'Week4_Project_Dataset'
        
        download.file(urL,paste(destFile,".zip",sep=""),mode='wb')
        unzipped <- unz(paste(destFile,".zip",sep=""),destFile)
        unlink(unzipped)
        
        ### Get training data and test data
        library(data.table)
        
        trainDataFolder <- paste(destFile,"/UCI HAR Dataset/train/"
                                 ,sep="")
        
        testDataFolder  <- paste(destFile,"/UCI HAR Dataset/test/"
                                 ,sep="")
        
        trainingSet <- fread(paste(trainDataFolder,"X_train.txt",sep=""))
        testSet <- fread(paste(testDataFolder,"X_test.txt",sep=""))
        
        trainLabels <- fread(paste(trainDataFolder,"y_train.txt",sep=""))
        names(trainLabels) <- "Activity.Label"
        
        testLabels  <- fread(paste(testDataFolder,"y_test.txt",sep=""))
        names(testLabels) <- "Activity.Label"
        
        subjectTrain <- fread(paste(trainDataFolder,"subject_train.txt",sep=""))
        names(subjectTrain) <- "Subject ID"
        
        subjectTest <- fread(paste(testDataFolder,"subject_test.txt",sep=""))
        names(subjectTest) <- "Subject ID"
        
        featsf <- paste(destFile,"/UCI HAR Dataset/features.txt"
                        ,sep="")
        
        feats <- fread(featsf)
        
        names(trainingSet) <- feats$V2
        names(testSet)     <- feats$V2
        
        trainingData <- data.frame(subjectTrain,trainLabels,trainingSet)
        testData     <- data.frame(subjectTest,testLabels,testSet)
        
        ### 1. Merge training set and test set to create one data set
        
        dataSet <- rbind(trainingData,testData)
        
        ### 2. Extract only the measurements on the mean and standard 
        ### deviation for each measurement.
        
        index <- grep("mean()|std()",names(dataSet))
        reducedDF <- dataSet[,c(1,2,index)]
        
        ### 3. Uses descriptive activity names to name the activities in 
        ### the data set
        
        activityNamesLookup <- fread(paste(destFile,"/UCI HAR Dataset/",
                                "activity_labels.txt",sep=""))
        
        activityNames <- character()
        
        for (i in reducedDF$Activity.Label){
                activityNames <- c(activityNames,activityNamesLookup$V2[i])
        }
        # Replaces activity numbers for activity names
        reducedDF$Activity.Label <- activityNames
        
        ###4. Appropriately label the data set with descriptive variable names
        
        feats <- names(reducedDF)[3:length(names(DF))]
        feats <- gsub("Freq","",feats)
        feats <- gsub("^t","Time",feats)
        feats <- gsub("^f","Frequency",feats)
        
        featsMod <- character()
        
        for (f in feats){
                if (grepl('mean',f)){
                        f <- gsub('mean',"",f)
                        f <- paste('mean',f,sep="")
                }
                else if (grepl('std',f)){
                        f <- gsub('std',"",f)
                        f <- paste('std',f,sep="")
                }
                featsMod <- c(featsMod,f)
        }
        feats <- featsMod
        
        colnames(reducedDF) <- c(names(reducedDF)[1:2],feats)
        reducedDF <- reducedDF[!duplicated(colnames(reducedDF))]
        
        ### 5. From the data set in step 4, creates a second, independent tidy 
        ### data set with the average of each variable for each activity and 
        ### each subject. 
        
        library(dplyr)
        
        grouped <- group_by(reducedDF,Subject.ID,Activity.Label)
        
        res <- summarize_each(grouped,funs(mean))
        
        return (data.frame(res))
}