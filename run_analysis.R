## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

if (!require("data.table")) {
    message("Installing data-table package")
    install.packages("data.table")    
    library("data.table")
} else {
    library("data.table")
    message("data-table package exists and skipping the installation.")
}

if (!require("reshape2")) {
    message("Installing reshape2 package")
    install.packages("reshape2")    
    library("reshape2")
} else {
    library("reshape2")
    message("reshape2 package exists and skipping the installation.")
}

######################################
# Load Files
######################################

# Load Activity Labels
activity_labels<-read.table("./data/UCI HAR Dataset/activity_labels.txt")[,2]

# Load Feature data column name
features<-read.table("./data/UCI HAR Dataset/features.txt")[,2]

# Load test result files: X_test, y_test and subject_test files
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Load train result files: X_train, y_train and subject_train files
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

######################################
# Process Test Files
######################################

#For test files,  extract only the measurements on the mean and standard deviation
#for each activity and each subject.
#use descriptive feature names as a column names of X_test
extract_features<-grep("mean|std",features)
names(X_test) <- features               #descriptive column names of the features.
X_test <- X_test[,extract_features]     #extract only mean and std from the test.

#Add new activity variable into y_test and assign proper column titles.
y_test[,2] <- activity_labels[y_test[,1]]
names(y_test) <- c("Activity_Id","Activity_Label")
names(subject_test) <- c("subject")

test_data <- cbind(subject_test,y_test,X_test)  #bind all test data columns.


######################################
# Process Train Files
######################################

#For train files,  extract only the measurements on the mean and standard deviation
#for each activity and each subject.
#use descriptive feature names as a column names of X_train

names(X_train) <- features                 #descriptive column names of the features.
X_train <- X_train[,extract_features]      #extract only mean and std from the train.

#Add new activity variable into y_train and assign proper column titles.
y_train[,2] <- activity_labels[y_train[,1]]
names(y_train) <- c("Activity_Id","Activity_Label")
names(subject_train) <- c("subject")

train_data <- cbind(subject_train,y_train,X_train)  #bind all train data columns.

# Merges training and test data sets to create one data set.
merge_data <- rbind(test_data,train_data)

id_labels <- c("subject","Activity_Id","Activity_Label")
data_labels <- setdiff(colnames(merge_data),id_labels)

meltdata <- melt(merge_data,id=id_labels,measure.vars=data_labels)

# Apply mean function to melt dataset using dcast function
tidy_data <- dcast(meltdata,subject+Activity_Label ~ variable, mean)

write.table(tidy_data,file="./data/tidy_data.txt",row.name=FALSE)

