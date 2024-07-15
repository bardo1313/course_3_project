# course_3_project

In this project we are going to read some tables that we have previously downloaded to our local drive.
The file features.txt contains the names of the variables. We are going to use these to name the columns
The file activity_labels.txt contains the names of the activities. We are going to use these in cmobination with Y_train and Y_test to add a new column with the activities
The files subjects_test.txt and subjects_train.txt contain the number of the subject for each row. We are going to bind them together and later bind it to the data frame as a new column called subject_number
The files X_train.txt and X_test.txt contain the values for each variable. And the files Y_train.txt and Y_test.txt the corresponding activity. We transform the values according to the activity_labels and bind everything together.
Then we select only the variables that represent mean and standard deviation for each measurement.
With this we create a new dataset and calculate the mean for each subject, each activity and each measurement 
