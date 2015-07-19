# PROJECT - Getting and Cleaning Data 

# Libraries
require(data.table)
require(dplyr)
require(tidyr)


# Files
features_file <- 'data/features.txt'
activity_label_file <- 'data/activity_labels.txt'
train_subject_file <- 'data/train/subject_train.txt'
train_data_file <- 'data/train/X_train.txt'
train_label_file <- 'data/train/y_train.txt'
test_subject_file <- 'data/test/subject_test.txt'
test_data_file <- 'data/test/X_test.txt'
test_label_file <- 'data/test/y_test.txt'

# Read the features and labels
features <- read.table(features_file)
features <- features[,2]
selected_features <- grepl('mean|std', features)
activity_labels <- read.table(activity_label_file)


# Read the training data
train_data_x <- read.table(train_data_file)
train_label_x <- read.table(train_label_file)
train_subject_x <- read.table(train_subject_file)

# Read the test data
test_data_x <- read.table(test_data_file)
test_label_x <- read.table(test_label_file)
test_subject_x <- read.table(test_subject_file)

# Label columns
names(train_data_x) = features
names(test_data_x) = features

# Keep mean and standard column only
meanstd_test_data_x <- test_data_x[,selected_features]
meanstd_train_data_x <- train_data_x[,selected_features]

# Label Data
test_label_x[,2] = activity_labels[,2][test_label_x[,1]]
train_label_x[,2] = activity_labels[,2][train_label_x[,1]]
names(test_label_x) = c('ActivityId', "ActivityLabel")
names(train_label_x) = c('ActivityId', "ActivityLabel")
names(train_subject_x) = c('Subject')
names(test_subject_x) = c('Subject')

# Bind columns together
test_data <- cbind(test_subject_x, test_label_x, meanstd_test_data_x)
train_data <- cbind(train_subject_x, train_label_x, meanstd_train_data_x)

# Merge train and test data
data = rbind(test_data, train_data)

# Gather Columns and Variables 
gather_data <- gather(data, MeasurementType, Value, -Subject, -ActivityId, -ActivityLabel)

tidy_data   = dcast.data.table(as.data.table(gather_data), Subject + ActivityLabel ~ MeasurementType, mean)

# Write Data to File
write.table(tidy_data, file = "./tidy_data.txt")
