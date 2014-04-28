# Assessments
# This R script does the following:
# 1. Merges the training and the test sets to create one data set.

X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X <- rbind(X_train, X_test)

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject <- rbind(subject_train, subject_test)

Y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
Y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
Y <- rbind(Y_train, Y_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

featuresFile <- read.table("UCI HAR Dataset/features.txt")
idx_good_features <- grep("-mean\\(\\)|-std\\(\\)", featuresFile[, 2])
X <- X[, idx_good_features]
names(X) <- featuresFile[idx_good_features, 2]
names(X) <- gsub("\\(|\\)", "", names(X))



# 3. Uses descriptive activity names to name the activities in the data set
activitiesFile <- read.table("UCI HAR Dataset/activity_labels.txt")
#activitiesFile[, 2] = gsub("_", "", tolower(as.character(activitiesFile[, 2]))) 
Y[,1] = activitiesFile[Y[,1], 2]
names(Y) <- "Activity"



# 4. Appropriately labels the data set with descriptive activity names.
names(subject) <- "Subject"
cleaned <- cbind(subject, Y, X)
write.table(cleaned, "merged_data.txt")



# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
uniqueSubjects = unique(subject)[,1]
numSubjects = length(unique(subject)[,1])
numActivities = length(activitiesFile[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
	for (a in 1:numActivities) {
		result[row, 1] = uniqueSubjects[s]
		result[row, 2] = activitiesFile[a, 2]
		tmp <- cleaned[cleaned$Subject==s & cleaned$Activity==activitiesFile[a, 2], ]
		result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
		row = row+1
	}
}
write.table(result, "data_averages.txt")

