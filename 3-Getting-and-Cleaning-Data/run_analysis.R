list.files("./UCI HAR Dataset", recursive = TRUE)
pathdata <- "./UCI HAR Dataset"

################################################ Reading the data ##############################################################

#Reading the testing tables
xtrain <- read.table(file.path(pathdata, "train", "X_train.txt"), header = FALSE)
ytrain <- read.table(file.path(pathdata, "train", "y_train.txt"), header = FALSE)
subject_train <- read.table(file.path(pathdata, "train", "subject_train.txt"), header = FALSE)

#Reading the testing tables
xtest <- read.table(file.path(pathdata, "test", "X_test.txt"), header = FALSE)
ytest <- read.table(file.path(pathdata, "test", "y_test.txt"), header = FALSE)
subject_test <- read.table(file.path(pathdata, "test", "subject_test.txt"), header = FALSE)

#Reading the features data
features <- read.table(file.path(pathdata, "features.txt"), header = FALSE)
colnames(features) <- c("FeatureID","Feature")

#Read activity labels data
activityLabels <- read.table(file.path(pathdata, "activity_labels.txt"), header = FALSE)
colnames(activityLabels) <- c("ActivityID", "Activity")

################################################ Labelling and Merging the data ################################################

#1 Merges the training and the test sets to create one data set

X <- rbind(xtrain, xtest)
colnames(X) <- features[,2]

Y <- rbind(ytrain, ytest)
colnames(Y) <- "ActivityID"

Subject <- rbind(subject_train, subject_test)
colnames(Subject) <- "SubjectID"

Merged_data <- cbind(X, Y, Subject)

################################################ Subsetting Mean and Standard deviation #######################################

#2 Extracts only the measurements on the mean and standard deviation for each measurement
library(dplyr)
TidyData <- Merged_data %>% select(contains("mean"), contains("std"), ActivityID, SubjectID)

################################################ Descriptive activity Names #####################################################

#3 Uses descriptive activity names to name the activities in the data set
TidyData$ActivityID <- activityLabels[TidyData$ActivityID, 2]

################################################ Descriptive Labels of variables ################################################
#4 Appropriately labels the data set with descriptive variable names
names(TidyData)[87] <- "Activity" #replacing the "ActivityID" with "Activity"

names(TidyData) <- gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData) <- gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData) <- gsub("BodyBody", "Body", names(TidyData))
names(TidyData) <- gsub("Mag", "Magnitude", names(TidyData))
names(TidyData) <- gsub("^t", "Time", names(TidyData))
names(TidyData) <- gsub("^f", "Frequency", names(TidyData))
names(TidyData) <- gsub("tBody", "TimeBody", names(TidyData))
names(TidyData) <- gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("angle", "Angle", names(TidyData))
names(TidyData) <- gsub("gravity", "Gravity", names(TidyData))

################################################ Average for each activity and subject ##########################################

#5 From the data set in step 4, creates a second, independent tidy data set with 
#  the average of each variable for each activity and each subject
FinalData <- TidyData %>%
  group_by(Activity, SubjectID) %>%
  summarise_all(mean)

################################################ Saving the data ###############################################################
write.table(FinalData, "FinalData.txt", row.name=FALSE)
