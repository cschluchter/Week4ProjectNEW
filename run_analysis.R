#Week 4 Project
#run_analysis.R

library(dplyr)

#load features - list of all features
features <- read.table("C:/Users/A42512/Documents/1-1/Training/Data Science Foundations using R Specialization/Part 3 - Getting and Cleaning Data/UCI HAR Dataset/features.txt", quote="\"", comment.char="", col.names = c("ID", "Feature"))

#load activity - list of activities
activity <- read.table("C:/Users/A42512/Documents/1-1/Training/Data Science Foundations using R Specialization/Part 3 - Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="", col.names = c("label", "Activity"))

########################################################

#load train data
#X_train - training set
X_train <- read.table("C:/Users/A42512/Documents/1-1/Training/Data Science Foundations using R Specialization/Part 3 - Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="", col.names = (features$Feature))

#y_train - training labels
y_train <- read.table("C:/Users/A42512/Documents/1-1/Training/Data Science Foundations using R Specialization/Part 3 - Getting and Cleaning Data/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="", col.names = ("label"))

#subject_train - each row identifies the subject who performed the activity
subject_train <- subject_train <- read.table("C:/Users/A42512/Documents/1-1/Training/Data Science Foundations using R Specialization/Part 3 - Getting and Cleaning Data/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="", col.names = c("subject"))

#combine all of the training data
train <- cbind(subject_train, y_train, X_train)

########################################################

#load test data
#X_test - test set
X_test <- read.table("C:/Users/A42512/Documents/1-1/Training/Data Science Foundations using R Specialization/Part 3 - Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="", col.names = (features$Feature))

#y_test - test labels
y_test <- read.table("C:/Users/A42512/Documents/1-1/Training/Data Science Foundations using R Specialization/Part 3 - Getting and Cleaning Data/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="", col.names = ("label"))

#subject_test - each row identifies the subject who performed the activity
subject_test <- read.table("C:/Users/A42512/Documents/1-1/Training/Data Science Foundations using R Specialization/Part 3 - Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="", col.names = c("subject"))

#combine all of the test data
test <- cbind(subject_test, y_test, X_test)

########################################################

#merge train and test data
combo <- rbind(train, test)

########################################################

#keep base columns (subject and label)
comboSubject <- combo[ , grepl("subject", names(combo))]
comboLabel <- combo[ , grepl("label", names(combo))]

#keep only columns with mean or standard deviation
comboMean <- combo [ , grepl("mean", names(combo))]
comboStd <- combo [ , grepl("std", names(combo))]

#bring subject, label, mean and standard deviation back together
comboMeanStd <- cbind(comboSubject, comboLabel, comboMean, comboStd)

########################################################

#add in activity labels to final data set
CleanData <- merge(comboMeanStd, activity, by.x = "comboLabel", by.y = "label")

#order the final data set by subject
CleanData <- arrange(CleanData, CleanData$comboSubject)

#reorder the columns, so it is Subject, ActivityLabel, Activity, rest of data
CleanData2 <- CleanData[,(c(2,1,82,3:81))]

########################################################

#Average of each variable for each Subject for each Activity

FinalResult <- aggregate(CleanData2[,4:82],list(CleanData2$comboSubject, CleanData2$comboLabel, CleanData2$Activity), mean)

#Rename columns in FinalResult
FinalResult <- rename (FinalResult, Subject = Group.1, Label = Group.2, Activity = Group.3)

#sort the FinalResult so it is easier to read
FinalResult2 <- (FinalResult[with(FinalResult, order(Subject,Label)),])

write.table(FinalResult2, file="C:/Users/A42512/OneDrive - Community Health Network/Documents/TidyData_FinalResult2.txt", row.names = FALSE)


