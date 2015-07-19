# Code Book

This codebook describes the source files and processing steps used to analyze the Human Activity Recognition Data from
University of California Irvine. The data was collected from smartphones' accelerometers and describes 6 different
activities

# Data Files

The following files are used for the analysis:

* `features.txt` contains the names of the features (collected values)
* `activity_labels.txt` contains the names of the 6 different activities
* `train/X_train.txt` contains the training data observations
* `train/subject_train.txt` contains the ids of the subjects used for training data
* `train/y_train.txt` contains the activity id related to the observation
* `test/X_test.txt` contains the test data observations
* `test/subject_test.txt` contains the ids of the subjects used for test data
* `test/y_test.txt` contains the activity id related to the observation

The original data set contains more files and information but only the files listed above where used in the analysis.


# Analysis / Cleanup

Steps:

1. All the data files are read into data.tables
2. Appropriate columns names are assigned from the `features.txt` file
3. All features that do not contain `mean` or `std` in their names are removed from the tables
4. The activities are labeled (using the activity Id and the corresponding text from `activity_labels.txt`)
5. The 3 tables (`subject id`, `activity` and `data`) are bound together
6. The 2 `test` and `training` data partitions are merge together
7. A tidy data table is created with the mean for each feature, each subject and each activity.
8. The tidy data table is written to a text file (CSV format) `tidy_data.txt`

# Output

The analysis script `run_analysis.md` generates a new text file containing the mean foreach mean and standard feature, each subject and each activity for both training and test sets.