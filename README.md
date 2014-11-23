### Getting and Cleaning Data

##  Course Project
The purpose of this project is to demonstrate the individual ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for the later analysis.

You should create one R script called run_analysis.R that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##  Steps to work this project

1. Download and extract the data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones into a folder on your local drive.
   You will have a UCI HAR Dataset folder with all the necessary data. 
2. Place the run_analysis.R file in the parent folder of UCI HAR dataset.
3. Make sure to set the current working directory to the parent folder using setwd() command.
4. Run source("run_analysis.R") and it will generate a new file tiny_data.txt in your working directory.

##  Dependencies
1. It depends on reshpae2 and data.table packages and run_analysis.R will install and load these dependencies.
2. The .zip data file needs to be downloaded and extracted before you run this R script.

##  About the Code Book
The CodeBook.md file contains the transformations performed and the resulting data and variables.



