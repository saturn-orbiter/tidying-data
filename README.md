# README.md

## Overview
This README file will explain the analysis file 'run_analysis.R'.
There are several functions defined in the file, and they are:

1. add_headers_to_activities
2. merge_to_tidy_subjects
3. merge_to_feature_measures
4. extract_means_stds
5. by_activity_person_mean

Thee first 2 functions tidy up original data files to comply with requirements of tidy data.
The third merge the training and test datasets of feature measurements.
The fourth calculates the means and standard deviations of all the feature measurements.
The last calculates the mean of the feature measurements per person per activity.

Before calling any of these functions, two folders have to be created: one for tidy data named simply 'dataset', and the other for the original dataset named 'dataset_old' which is the replacement name of the former folder afte unzipping the data from the link: 

linxxxxx.

calls to functions in the 'dplyr' package are made, and thus, the dplyr package has to be installed.

## add_headers_to_activities
This function transforms the data on activities stored in 'activity_labels.txt' to one with column headers 'id' and 'activity' in this order.

## merge_to_tidy_subjects
This function combines the two files 'train/subject_train.txt' and 'test/subject_test.txt' into one file called 'subjects.txt' without the repetition that is needed to merge with the feature measurement files 'train/X_train.txt' , or, 'test'/X_test.txt'.

## merge_feature_measures
This function combines all the feature measurements from training and test into one file stored in 'dataset' folder, named 'feature_meas.txt'. The combination is done in 3 stages.

_In the first stage_, the training files 'y_train.txt', 'subject_train.txt', and 'X_train.txt' in this order are combined columnwise.
To be able to combine them, they must have column proper column headers. For the first two, the column names are 'act.id' and 's.id' in this order. For the remaining columns, a helper function called _get_feature_names_.

The function _get_feature_names_ simply extracts the feature variable names stored in the file 'dataset_old/features.txt' where each of the variables are described in the file 'dataset_old/features_info.txt'. However, the extracted strings contain invalid characters such as dashes, commas, and parentheses. Thus, they are removed from the vector of names. Some of the names have two dashes, where the first dash signifies subtraction, and thus, to make a name more descriptive, the first dash is replaced by the word 'Less'. In the course of obtaining valid names for columns, it is found that there are duplicates; duplicates are not removed.

With "act.id", "s.id" and the feature names comprising the vector of column names, the combined data is assigned with the previously mentioned vector of names.

_In the second stage_ is identical to the first stage except that the test files 'y_train.txt', 'subject_train.txt', and 'X_train.txt' are the ones combined columnwise, and that vector of column names is already available for adding to the combined data.

_In this last stage_, the two sets of combined data are in turn combined into one rowwise. Lastly, the duplicated feature measurement columns are removed from the combination, and then stored as 'feature_meas.txt' in the 'dataset' folder.

## extract_means_stds
This function calculates the means and standard deviation of all the feauture measurements stored in 'feature_meas.txt' by doing the following:

a. loading the data in 'feature_meas.txt'
b. subsetting the all the columns except the columns for the activity and subject.
c. calculating the means of all columns by a call to summarise_all.
d. calculating the standard deviations by another call to summarise_all.
e. Combining rowwise the two previous results and returning the combination.

## by_activity_person_mean
This function function calculates the means of all the feature measuremnets per person per activity. To do this, the doing the following:

a. loading the data in 'feature_meas.txt'
b. grouping the data by activity, and subject in this order.
c. calculating the means of all columns by a call to summarise_all.
d. sorting the result of previous step by activity, and subject in this order.
e. merging the result of the previos with the activities file.
f. and returning the result.
