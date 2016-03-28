Code Book of Week 4 Project (Getting and Cleaning Data)
2016-03-27


Table of Variables
------------------

Variables             definition
-----------------------------------------------------------------
activity_averages   - a dataframe that calculate the averages of 
                      all variables against "activity", this dataframe 
                      is incorporated into the submitted file
activity_labels     - a dataframe that contains the look up tables of 
                      activity labels 
dataMelt            - a dataframe that melts extracted_df
extracted_df        - a dataframe with features that are calculated 
                      means or standard deviations
extracted_features  - a dataframe that contains the column indices 
                      and the names of the extracted features
features            - a dataframe that contains the names of all the 
                      original features
final_df            - the final dataframe from step 5
label_feature       - a 1 x 2 dataframe that contains the column index 
                      and the name of the activity_label column
                      used for creating the variable labels/names for 
                      extracted_df
merged_df           - an interim dataframe as the result of step 1
subject_averages    - a dataframe that calculate the averages of all 
                      variables against "subject", this dataframe is 
                      incorporated into the submitted file
subject_feature     - an 1 x 2 dataframe similar to label_feature, 
                      used to for creating the variable labels/names 
                      for extracted_df
test_data           - a dataframe created from the X_test.txt file
test_df             - a dataframe that merges all the test data
test_label          - a dataframe created from the y_test.txt file
test_subject        - a dataframe created from subject_test.txt file
train_data          - a dataframe created from the X_train.txt file
train_df            - a dataframe that merges all the train data
train_label         - a dataframe created from y_train.txt file
train_subject       - a dataframe created from subject_train.txt file


Flow of Creation of interim variables (Step 1 -> Step 4)
--------------------------------------------------------------------
train_data (X_train.txt)
train_label (y_train.txt)   ===> train_df
train_subject(subject_train.txt)         \
                                          ===> merged_df(step 1)
test_data (X_test.txt)                   /
test_label (y_test.txt)     ===> test_df
test_subject (subject_test)


features (features.txt)              
label_feature                ===> extracted_features 
subject_feature                   (for feature names)


extracted_features --->    colnames(extracted_df) (step 4)
               \
merged_df        ===>  extracted_df (step 2)      
                                          \      extracted_df 
                                           ===> with label names 
                                                    (Step 3)
                                         /
activity_labels(activity_labels.txt)    /   


Final data set
---------------------------------------------------------------
                              activity_averages
                             /                  \
extracted_df  ===> meltData |                    | ===> final_df 
                             \                  / 
                              subject_averages

             write.csv()
final_df         ===>         Week4_Project_Result.csv
