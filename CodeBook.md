# Code Book
## Overview
In this project entitled "Getting and Cleaning Data", it is required to get data from a study of wearable computing, tidy it, and make summaries from tidy data. See reference below for the study [1].

## The Original Dataset

The original dataset is downloaded from the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

Once downloaded, the file is unzipped which produces a folder of data. The original folder is renamed to 'dataset_old' for purposes of the analysis.

## The Tidy Dataset

The tidy dataset is stored in the folder named simply 'dataset'. For the purpose of the analysis, this folder and the folder of original dataset 'dataset_old' should be stored under the same parent folder.

In the folder 'dataset', the following files are stored:

a.  activities.txt
a.  subjects.txt
a.  feature_meas.txt.zip (zipped version of feature_meas.txt containing all the feature measurements made per activity per person.
a.  features.txt which list all the names of all the features measured in the study.
a.  features_info.txt which describes the various features that were measured.

### Activities
The activity data are stored in the 'activities.txt'. There are two variables: id, and the activity (name). 

The activity names (or labels) are: WALKING, SITTING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING. 
The id is simply an integer that varies from 1 to 6, assigned to an activity uniquely.

### Subjects
The subjects (people) data are stored in the 'subjects.txt'. There is only variable named 'id' which is an integer assigned to the 30 people involved the feature measurements for all the activity. Thus, the values of the id's range from 1 to 30. During the tidying, the data is sorted in ascending order.

To produce this file, the data in the 'subject_test.txt' and 'subject_train.txt' are combined, removing duplications required to merge with the feature measurements file, 'X_train.txt' and 'X_test.txt' respectively.

### Feature Measurements
Again, the 'feature_meas.txt' stores the measuresements of 561 variables per person per activity plus the id's of the activity and subject, which are the first two columns of the file.

This file is the result of combining 'subject_xxx.txt', 'X_xxx.txt', 'y_xxx.txt, where xxx is either train or test to imply mesurements done during the training or testing category. Thus, to produce 'feature_meas.txt', the following are done:

a. the 3 files of training category are combined into one dataset.
b. the 3 files of testing category are combined into the second dataset.
c. the two previous datasets are further combined into a third dataset. 

In the process of producing overall combination, it is discovered that some feature variables are duplicated, and thus, eliminated, reducing the number of feature variables from 561 to 477.

For the description of the each of these feature variables, refer to the file named 'features_info.txt' in the folder 'dataset'. For the original list of 561 feature variables, refer to the file 'features.txt' in the folder 'dataset'.

## Reference

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


