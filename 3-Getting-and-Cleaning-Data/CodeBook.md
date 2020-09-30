Code Book
The run_analysis.R script performs the data preparation and then followed by the following steps required as described in the 
course projects definition.

1. The data was downloaded and extracted under the folder called UCI HAR Dataset

2. Each data was assigned to variables
i) xtrain, ytrain, subject_train from the train folder
ii) xtest, ytest, subject_test from the test folder
iii) features: The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
iv) activityLabels which is the list of activities performed when the corresponding measurements were taken and its codes (labels)

3. The train and test data was merged using the rbind() function and assigned to X, Y and Subject variables. Then, these are merged by using the cbind() functions to create a dataset names as Merged_data.

4. This data was subsetted to those variables which contained mean and standard deviation along with two additional columns for ActivityID and SubjectID using the select() function from the package dplyr. This data is stored in a variable called as TidyData.

5. The ActicityIDs were replaced by descriptive activities taken from second column of the ActivityLabels.

6. The column name for ActivityID is now appropriately labelled  with "Activity". Other descriptive variable names of the TidyData are renamed using gsub function and regular expressions.

7. Finally, the data was grouped by Activity and SubjectID using the group_by() function. To average the value of each variable for each Activity and Subject the summarize_all function was used passing with mean. 

8. This independent tidy data set with the average of each variable for each activity and each subject FinalData (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Finally, this was exported into FinalData.txt file.