
library(dplyr)

download_file_name <- "Dataset.zip"
# Checking if archieve already exists.
if (!file.exists(download_file_name)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, download_file_name, method="curl")
}  

# Checking if folder exists
if (!dir.exists("UCI HAR Dataset")) { 
  unzip(download_file_name) 
}


# TASK ONE: Merges the training and the test sets to create one data set.
# Read the data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Merge the training and testing data
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

# Set the names of the columns
names(x) <- features[,2]
names(y) <- "activity"
colnames(activity_labels) <- c('activity','activityName')
names(subject) <- "subject"

# Merge the data
df <- cbind(x, y, subject)

# TASK TWO: Extracts only the measurements on the mean and standard deviation for each measurement. 
colName  <- colnames(df)

mean_and_std <- (grepl("activity" , colName) | 
                     grepl("subject" , colName) | 
                     grepl("mean.." , colName) | 
                     grepl("std.." , colName) 
)

sub_df <- df[,mean_and_std==TRUE]

# TASK THREE: Uses descriptive activity names to name the activities in the data set

sub_df<-sub_df %>% left_join(activity_labels,by="activity")

#TASK FOUR: Appropriately labels the data set with descriptive variable names
names(sub_df)<-gsub("Acc", "Accelerometer", names(sub_df))
names(sub_df)<-gsub("Gyro", "Gyroscope", names(sub_df))
names(sub_df)<-gsub("BodyBody", "Body", names(sub_df))
names(sub_df)<-gsub("Mag", "Magnitude", names(sub_df))
names(sub_df)<-gsub("^t", "Time", names(sub_df))
names(sub_df)<-gsub("^f", "Frequency", names(sub_df))
names(sub_df)<-gsub("tBody", "TimeBody", names(sub_df))
names(sub_df)<-gsub("-mean()", "Mean", names(sub_df), ignore.case = TRUE)
names(sub_df)<-gsub("-std()", "STD", names(sub_df), ignore.case = TRUE)
names(sub_df)<-gsub("-freq()", "Frequency", names(sub_df), ignore.case = TRUE)
names(sub_df)<-gsub("angle", "Angle", names(sub_df))
names(sub_df)<-gsub("gravity", "Gravity", names(sub_df))

# STEP FIVE: From the data set in step 4, creates a second, independent tidy 
# data set with the average of each variable for each activity and each subject.
output <- sub_df %>% group_by(subject,activityName) %>% summarise_all(list(mean))

if (!dir.exists("output")) { 
  dir.create("output")
}

write.csv(output,"./output/output_data.csv")

