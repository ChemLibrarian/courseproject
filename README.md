This project is to demonstrate my ability to collect, work with and clean a data set and is a requirement by the course project of Getting and Cleaning Data provided by John Hopkins University through Coursera.

This Repo includes the following files:
=========================================
- 'README.md' contains explanations on how all scripts work and how they connected. 
- 'codebook.md' contains descriptions of variables included. 
- 'run_analysis.R' contains the R function used to clean the raw data sets and assemeble the cleaned dataset. 
- 'tidydata.txt' contains the cleaned and re-assemebled dataset resulted from the 'run_analysis.R' script.

Data source: 
=========================================
The data used in this project was collected from the accelerometers from the Samsung Gallaxy S Smartphone and made available through the website http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
The data set used in the project is donwloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Starting condition: 
=========================================
The data set is downloaded, unziped in the folder 'UCI HAR Dataset', and saved under the folder 'courseproject' together with the 'run_analysis.R' script. The 'courseproject' folder is saved under the current working directory where you run R. 

If you downloaded this repo, please save it under a folder named 'courseproject and put the folder in your R working directory. And then, download the dataset mentioned in Data source section and also save the 'UCI HAR Dataset' folder under the 'courseproject' folder. 

Running the script: 
=========================================
Use the following R script to source the 'run_analysis.R' as a function without arguments.
        source("./courseproject/run_analysis.R")
        run_analysis()

The function will write a file named 'tidydata.txt' under the './courseproject' folder. 

Due to the data file size, it may take a while for the funciton to finish. It usually takes about 35 seconds on my MacBookPro with OS 10.9.5, 2.8GHz Intel Core i7, 16GB 1600 MHz DDR3 and in RStudio v0.98.1103. 

Data analysis process:
=========================================
Here is the cleanup and re-assemble proccess applied to the raw data. 
1. The following data files are read into R as raw data.
        Under training folder: 'X_training.txt', 'y_training.txt', 'subject_training.txt'
        Under testing folder: 'X_test.txt', 'y_text.txt', 'subject_training.txt'
        Under the main UCI HAR Dataset folder: 'features.txt', 'activity_label.txt'
        
2. X_training and X_test are row-binded to form the main dataset. 

3. Use the variable names listed in 'features.txt' to name the columns in the main dataset. 

4. Extract the columns with "mean()" or "std()" from the main dataset to form the extracted dataset by using the 'grep' untion to retrieve the index of the targeted columns. The index of the columns were sorted inscendently to ensurer the order of the columns stays the same as the main dataset. 

5. To add the activity description to each observation as an additional column by (1) row-binding the data representing activities (y_traing and y_test) as the activity vector y; (2) using a "for loop" to replace the number representing the activities in y with the corresponding descriptive activity by comparing to the activity labels listed in 'activity_label.txt'. (3) adding y as a new column named "Activity" to the extracted dataset obtained in 4. 

6. To add the Subject information as an additional column to the data by (1) row-binding the subject_training and subject_test to obtain the full subject list; (2) adding the vector containing the full subject list as a new column named "Subject" to the extracted dataset obtained in 5. 

7. To create a second, independent tidy data set with the average of each variable for each activity and each subject, (1) use "melt"" function to create a long and narrow dataset with "Subject" and "Activity" as id and the rest of the variables as measured.variables. (2) use function "decast"" to create a summary of mean of each variable for each subject and each activity from the melted dataframe. 

8. Use the write.table function to create the "tidydata.txt" file containing the re-assembled dataset from 7. 

Interpreting data: 
=========================================
The cleaned and re-assembled data 'tidydata.txt' can be interpreted as described in codebook.md. 