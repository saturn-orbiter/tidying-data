# run_analysis.R

# This program assumes that the folder containing the original dataset has
# been renamed to 'dataset_old', and the new folder containing the tidy
# dataset is simply named 'dataset'. Both will be under the same parent folder
# which is named by the auth or as 'project'. Thus, current working directory
# should be set to 'project' before running this script.
# e.g, setwd("~/<user>/Downloads/DataSciSpz_Module3/project')

library(dplyr)

# PREPROCESSING
src_path <- "dataset_old"
dest_path <- "dataset"

add_headers_to_activities <- function() {
  # column names to the 'activity_labels.txt' producing
  # a new file 'activities.txt'.
  src <- file.path(src_path, "activity_labels.txt") 
  dest <- file.path(dest_path, "activities.txt" )
  a <- read.table(src)
  write.table(a, dest, quote = FALSE, row.names =FALSE, 
              col.names = c("id", "activity"))
}

merge_to_tidy_subjects <- function() {
  # combine two 'subject_x.txt' files into one named 'subjects.txt' that 
  # is sorted, and without duplications
  
  s.train <- file.path(src_path, "train", "subject_train.txt")
  s.test <- file.path(src_path, "test", "subject_test.txt")
  s1 <- read.table(s.train)
  s2 <- read.table(s.test)
  s3 <- rbind(s1, s2)
  s3 <- unique(s3) # remove duplications
  # sort id column
  colnames(s3) <- c("id")
  s3 <- arrange(s3, id)
  dest <- file.path(dest_path, "subjects.txt")
  write.table(s3, dest, quote=FALSE, row.names = FALSE, col.names = "id")
}

get_feature_names <- function() {
  # get the feature names from 'features.txt', applying
  # several modifications to make them valid column names
  
  # read the features.txt file
  f <- read.table(file.path(src_path, "features.txt")) # no headers
  colnames(f) <- c("id", "fname")
  fv <- f$fname #get the second column as character vector
  # perform several text operations to make them valid variable names
  # look for the first dash and replace with the word 'Less'
  fv <- sub("-", "Less", fv)
  # remove parentheses not enclosing chars
  fv <- sub("()", "", fv, fixed=TRUE) # parentheses should be considered as literals
  # for those remaining parentheses enclosing characters
  # remove "("
  fv <- sub("(", "_", fv, fixed=TRUE) # replace with underscore
  # remove ")" located at the end of strings
  fv <- sub(")$", "", fv)
  fv <- sub(")", "", fv) # remove any other closing parenthesis
  # replace remaining dashes with underscores
  fv <- sub("-", "_", fv)
  # as LAST step, replace commas with periods
  sub(",", ".", fv)
}

merge_feature_measures <- function() {
  # Merges the feature measurements from both 'train' and 'test'
  # subfolder, while retaining which subject did which activity
  
  # part 1: merge 3 training files in order: 
  #       y_train.txt, subject_train.txt, X_train.txt
  
  # set paths
  sub_folder <- "train"
  f1 <- file.path(src_path, sub_folder, "y_train.txt")
  f2 <- file.path(src_path, sub_folder, "subject_train.txt")
  f3 <- file.path(src_path, sub_folder, "X_train.txt")
  
  # read in the data
  d1 <- read.table(f1)
  d2 <- read.table(f2)
  d3 <- read.table(f3)
  cd1 <- cbind(d1, d2, d3) # first combined data
  
  # set the column names
  # get the last 561 variable names from the features.txt file
  cn <- get_feature_names()
  cn <- c(c("act.id", "s.id"), cn)
  colnames(cd1) <- cn
  
  # part 2: merge 3 test files in order: 
  #       y_test.txt, subject_test.txt, X_test.txt
  
  # set paths
  sub_folder <- "test"
  f1 <- file.path(src_path, sub_folder, "y_test.txt")
  f2 <- file.path(src_path, sub_folder, "subject_test.txt")
  f3 <- file.path(src_path, sub_folder, "X_test.txt")
  
  # read data
  d1 <- read.table(f1)
  d2 <- read.table(f2)
  d3 <- read.table(f3)
  cd2 <- cbind(d1, d2, d3)
  colnames(cd2) <- cn
  
  # part 3: combine rowwise
  # finally merge into one dataset: WOW columns names are essential 
  cd3 <- rbind(cd1,cd2)
  
  # REMOVE DUPLICATE columns
  cd3 <- cd3[, !duplicated(cn)]
  dest <- file.path(dest_path, "feature_meas.txt")
  write.table(cd3, ?dest, quote=FALSE, row.names = FALSE, col.names = TRUE)
}

extract_means_stds <- function() {
  # extract the means and standard deviations of all the measurements
  
  # read the 'merged feature measurements file'
  path <- file.path(dest_path, 'feature_meas.txt')
  d <- read.table(path, header=TRUE)
  # get all columns except the first 2: act.id, s.id
  d <- select(d, -(act.id:s.id))
  # convert each column to numeric
  d  <- mutate_all(d, as.numeric)
  
  # mean_vals <- sapply(d1, mean, na.rm=TRUE)
  # std_vals <- sapply(d1, sd, na.rm=TRUE)
  mean_vals <- summarise_all(d, mean)
  std_vals <- summarise_all(d, sd)
  data.frame(rbind(mean_vals, std_vals), row.names = c("mean", "std"))
}  

by_activity_then_by_person_mean <- function() {
  # this function groups the data by activity and subject, in this order
  # then calculates the mean all the variables
  path <- file.path(dest_path, 'feature_meas.txt')
  d <- read.table(path, header=TRUE)
  d <- group_by(d, act.id, s.id) # group by activity, then subject
  d <- summarise_all(d, mean)
  d <- arrange(d, act.id, s.id) # sort by activity, then subject
  # merge with the 'activities.txt'
  # read in 'activities.txt'
  a <- read.table(file.path(dest_path, 'activities.txt'),header = TRUE)
  ad <- merge(a, d, by.x = 'id', by.y='act.id')
  select(ad, -id)
}
# ALL function call will be after this comment

# 1: add_headers_to_activities()
# 2: merge_to_tidy_subjects()
# 3: merge_feature_measures()
# 4: c <- extract_means_stds()
# 5: d <- by_activity_person_mean()