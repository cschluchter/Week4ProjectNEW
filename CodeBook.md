CodeBook - Week 4 Project
==================================================================

Section 1 of Code: 
- Loads in the "features.txt" to get all of the features
- Loads in the "activity_labels.txt" to get the activities

Section 2 of Code:
- Loads all of the training data and combines them into one data set (subject_train, y_train, X_train)

Section 3 of Code:
- Loads all of the test data and combines them into one data set (subject_test, y_test, X_test)

Section 4 of Code:
- Binds the training and testing data into one data set

Section 5 of Code:
- Keeps the Subject, Label and only the columns that measuring the mean or standard deviation

Section 6 of Code:
- Adds the "activity labels" into the cleanded data set
- Reorders the columns in the cleaned data set to make it easier to read

Section 7 of Code:
- Takes the average of each variable for each Subject for each Activity
- The end result is called "FinalResult2"