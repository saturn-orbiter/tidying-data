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

Before calling any of these functions, two folders have created: one for tidy data named simply 'dataset', and the other for the original dataset named 'dataset_old' which is the replacement name of the former folder afte unzipping the data from the link: 

## add_headers_to_activities
This function transforms the data on activities stored in 'activity_labels.txt' to one with column headers 'id' and 'activity' in this order.

## merge_to_tidy_subjects
This function combines the two files 'train/subject_train.txt' and 'test/subject_test.txt' into one file called 'subjects.txt' without the repetition that is needed to merge with the feature measurement files 'train/X_train.txt' , or, 'test'/X_test.txt'.

## merge_feature_measures
This function combines all the feature measurements from training and test into one file stored in 'dataset' folder, named 'feature_meas.txt'. The combination is done in 3 stages.

In the first stage, the training files 'y_train.txt', 'subject_train.txt', and 'X_train.txt' in this order are combined columnwise.
To be able to combine them, they must have column proper column headers. For the first two, the column names are 'act.id' and 's.id' in this order. For the remaining columns, a helper function called _get_feature_names_.

## extract_means_stds

## by_activity_person_mean
