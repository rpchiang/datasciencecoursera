                                  README
Coursera course "Getting and Cleaning Data"

There is only one R script, run_analysis.R, created for the Week 4 project assignment. The script assumes that the working directory has been set to the root directory of the data, i.e., UCI HAR Dataset.

The script follows the process described below:
1. Read the train data set and created combined data frame

2. Read the test data set and created combined data frame

3. Merge train data frame with test data frame (result for Step 1)

4. Extract only the measurements on the mean and standard deviation for each measurement (Step 2)
  a. Extracted features that contain "mean" and "std"
  b. Merged the extracted features with the activity_label features
  c. Subsetting the merged_df using the extracted features (V1 is the row index)

5. Uses descriptive activity names to name the activities in the data set (Step 3)
  a. read the activity labels
  b. substitute the label with the label names using gsub

6. Labels the data set with descriptive variable names (set columns names)(Step 4)

8. From the data set in step 4, creates a second, independent tidy data set (Step 5)
  a. melt the extracted dataframe
  b. dcast the melt data to calculate the means of all variables against activities
  c. dcast the melt data to calculate the means of all variables against subjects
  d. Bind the two data frames
