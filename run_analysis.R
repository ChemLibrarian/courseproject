run_analysis <- function () {
        
        ## This R script is used to get and clean a data set obtained from 
        ## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
        ## as required by the course project of Getting and Cleaning Data provided by 
        ## John Hopkins University through Coursera. 
        
        ## Read data files
        subject_train <- read.table("./courseproject/UCI HAR Dataset/train/subject_train.txt")
        X_train <- read.table("./courseproject/UCI HAR Dataset/train/X_train.txt")
        y_train <- read.table("./courseproject/UCI HAR Dataset/train/y_train.txt")
        subject_test <- read.table("./courseproject/UCI HAR Dataset/test/subject_test.txt")
        X_test <- read.table("./courseproject/UCI HAR Dataset/test/X_test.txt")
        y_test <- read.table("./courseproject/UCI HAR Dataset/test/y_test.txt")
        features <- read.table("./courseproject/UCI HAR Dataset/features.txt")
        activity_labels <- read.table("./courseproject/UCI HAR Dataset/activity_labels.txt")
        
        ## Merges the training and the test sets to create one data set
        dataset <- rbind (X_train, X_test)
        
        ## Appropriately labels the data set with descriptive variable names as column names
        names(dataset) <- features[ , 2]
        
        ## Extracts only the measurements on the mean and standard deviation for each measurement
        dataset_extract <- dataset[ , sort(c(grep("mean()", names(dataset)), grep("std()", names(dataset))))]
        
        ## Uses descriptive activity names to name the activities in the data set 
        ## Add activity lables as an additional column to the dataset
        y <- rbind(y_train, y_test)
        ylabel <- data.frame(matrix(ncol = 1, nrow = nrow(y)))
        for (i in 1:nrow(y)) {
                ylabel[i, ]<- as.character(activity_labels[(which(activity_labels[ ,1] == y[i, ])), 2])
        }
        dataset_extract[ , "Activity"] <- ylabel
               
        ## Add Subject column 
        subject <- rbind(subject_train, subject_test)
        dataset_extract[, "Subject"] <- subject
        
        ## creates a second, independent tidy data set with the average of each variable 
        ## for each activity and each subject
       library(reshape2)
       dataset_melt <- melt(dataset_extract, id = c("Subject", "Activity"), measure.vars = names(dataset_extract[ , 1:(ncol(dataset_extract)-2)]))
       mean_sub_activity <- dcast(dataset_melt, Subject + Activity ~ variable, mean)
       
        ## create a txt file containing the final result 
       write.table(mean_sub_activity , file = "./courseproject/tidydata.txt", row.names = FALSE)
}