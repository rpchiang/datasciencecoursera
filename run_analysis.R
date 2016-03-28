# R script for the project assignment from Coursera course "Getting and Cleaning Data"
# The working directory needs to be set to the root directory of the data set
library(reshape2)
library(dplyr)

# read the train data set and created combined data frame
train_data    <- read.table("./train/X_train.txt", header=FALSE, stringsAsFactors=FALSE)
train_label   <- read.table("./train/y_train.txt", header=FALSE, stringsAsFactors=FALSE)
train_subject <- read.table("./train/subject_train.txt", header=FALSE, stringsAsFactors=FALSE)
train_df      <- cbind(train_label, train_subject, train_data)

# read the test data set and created combined data frame
test_data     <- read.table("./test/X_test.txt", header=FALSE, stringsAsFactors=FALSE)
test_label    <- read.table("./test/y_test.txt", header=FALSE, stringsAsFactors=FALSE)
test_subject  <- read.table("./test/subject_test.txt", header=FALSE, stringsAsFactors=FALSE)
test_df       <- cbind(test_label, test_subject, test_data)

# 1. merge train data frame with test data frame
merged_df    <- rbind(train_df, test_df)

# 2. Extract only the measurements on the mean and standard deviation for each measurement
#   a. Extracted features that contain "mean" and "std"
features           <- read.table("./features.txt", header=FALSE, stringsAsFactors=FALSE)
extracted_features <- features[grep("mean|std", features$V2),]

#   b. Merged the extracted features with the activity_label feature
label_feature         <- data.frame(V1=1, V2="activity_label")
subject_feature       <- data.frame(V1=2, V2= "subject")

#      adjust the index by adding 2 to accomodate the activity label and subject
extracted_features$V1 <- extracted_features$V1 + 2  

#      insert the activity_label and subject features
extracted_features    <- rbind(label_feature, subject_feature, extracted_features) 

#   c. Subsetting the merged_df using the extracted features (V1 is the row index)
extracted_df    <- merged_df[ ,extracted_features$V1]

# 3. Uses descriptive activity names to name the activities in the data set
#   a. read the activity labels
activity_labels <- read.table("./activity_labels.txt", header=FALSE)

#   b. substitute the label with the label names using gsub
for(ilabel in 1:nrow(activity_labels))
{
  extracted_df$V1 <- gsub(activity_labels$V1[ilabel], activity_labels$V2[ilabel], extracted_df$V1)
}

# 4. Labels the data set with descriptive variable names 
#   set the column names for the extracted dataframe and labels (V2 contains the feature names)
colnames(extracted_df) <- extracted_features$V2

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject
#    a. melt the extracted dataframe
dataMelt                    <- melt(extracted_df, id=c("activity_label", "subject")) 

#    b. dcast the molten data to calculate the means for all variables against activities and subjects
activity_averages           <- dcast(dataMelt, activity_label ~ variable, mean)
subject_averages            <- dcast(dataMelt, subject ~ variable, mean)

# make the first column names the same for binding
names(activity_averages)[1] <-"activity_or_subject"
names(subject_averages)[1]  <-"activity_or_subject"

# merge two data frames
final_df                    <- rbind(activity_averages, subject_averages)
write.csv(final_df, file="Week4_Project_Result.csv")
