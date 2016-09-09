## Summary

This is repo created for Assignment Project of 'Getting and Cleaning Data' course in Course John Hopkins Data Science Specialization.
The project is about tidying a data set and documenting the data manipulation process and final data set.


## Project Details

Input data can be downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Data Manipulation Instructions:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Description of processing in run_analysis.R

1. To begin with, the required library dplyr is imported.
2. X_train.txt and X_test.txt are imported respectively as data frames and are concatenated to form a feature data frame 'X'.
3. To rename the columns of X, features.txt is imported as data frame and its last column is used as naming vector to X header. To improve readability, the "()" in naming vector is replaced with "".
4. subject_train.txt and subject_test.txt are imported and concatenated to form a data frame 'subject'. 
5. Its only column is renamed as subject. Subsequently, X is appended with the subject column.
6. y_train.txt and y_test.txt are imported respectively as data frames and are concatenated to form a label data frame 'y'. Its only column is named activity_id.
7. To include a descriptive activity label, activity_labels.txt is imported and is left-joined to the data frame y.
8. Columns in y are then appended to X to complete a data frame df.
9. To create a data frame 'subset_df' with columms of interest (mean & std), df is subsetted through columns id obtained from case-insensitive grep function.
10. The activity column is then appended to subset_df.
11. The final data frame df_mean is created through dplyr, subset_df is group by activity and subject and each column is summarised by mean function.
12. Feature column names are then prefixed with 'Mean_of'

## How to reproduce the final data set 'mean_df.txt'
1. Make a main folder containing the run_analysis.R and the downloaded,unzipped input data (link above)
2. Changing working directory to the main folder and source run_analysis.R
