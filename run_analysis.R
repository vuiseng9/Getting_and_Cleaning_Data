# run_analysis.R
# go to working directory
# setwd('C:/Users/vchua/Desktop/MyProCert/Getting_and_Cleaning_Data/project/')

library(dplyr)

# Import train feature matrix
X_train <- read.table('UCI HAR Dataset/train/X_train.txt',header = FALSE)

# Import test feature matrix
X_test <- read.table('UCI HAR Dataset/test/X_test.txt',header = FALSE)

# Concatenate train and test feature matrix
X <- rbind(X_train,X_test)

# Import feature names
features <- read.table('UCI HAR Dataset/features.txt',header=FALSE)

# renaming the column names with the last column of data frame "features'
# getting rid of '()"
names(X) <- gsub("\\(\\)","",as.character(features[[-1]]))

# Import train subject
subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt',header=FALSE)

# Import test subject
subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt',header=FALSE)

# Concatenate train and test subject
subject <- rbind(subject_train,subject_test)
names(subject) <- "subject"

# Appending subject to X
X$subject <- subject$subject

# Import train label
y_train <- read.table('UCI HAR Dataset/train/y_train.txt',header = FALSE)

# Import test label
y_test <- read.table('UCI HAR Dataset/test/y_test.txt',header = FALSE)

# Concatenate train and test train label
y <- rbind(y_train,y_test)

# Renaming the col as activity_id since they are integer values
names(y) <- "activity_id"

# Import lookup table of integer to activity
label <- read.table('UCI HAR Dataset/activity_labels.txt',header = FALSE)

# Renaming the columns of the lookup dataframe
names(label) <- c("activity_id","activity")

# left join on y with label, output is a dataframe with id and activity
# Do avoid of sorting to keep the label in the right order to the feature matrix
y <- merge(y,label,by = "activity_id",all.x = TRUE, sort = FALSE)

# Bind feature matrix to label to form a master dataframe
df <- cbind(X,y)

# Subsetting to only mean and std columns
subset_df <- df[grep("mean|std",names(df),ignore.case = TRUE)]
subset_df$activity <- df$activity
subset_df$subject <- df$subject

# dataset of feature mean per activity
df_mean <- 
  subset_df %>% 
  group_by(activity,subject) %>% 
  summarise_each(funs(mean))

# adding "Mean_of_" prefix to the column header
names(df_mean)[3:88] <- paste0("Mean_of_",names(df_mean)[3:88])
write.table(df_mean, file = "df_mean.txt",row.names = FALSE)
