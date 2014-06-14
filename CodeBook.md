# Code Book for the Human Activity Recognition Using Smartphones Tidy Data
==========================================================================

## Introduction
*Author*: Stephan E. Fabregas
*Class*: Getting and Cleaning Data, Coursera, June 2014

This codebook describes the tidy data set (tidy_data.txt) created by running the run_analysis.R script. For more detailed information about the script and the data cleaning process, see README.md.

## Cleaning the data
This section provides an overview of the data cleaning process. For a detailed description of how the run_analysis.R script functions, see README.md.

Raw data were downloaded [here](https://d396qusza40orc.cloudfront.net/getData%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The data of interest, unzipped into the "UCI HAR Dataset" folder, are the subject ids, actual data, and the activities list in both the test and train folders. These data were the raw data source for the creation of the tidy data set.

Data were combined into a single long file (each row is a single observation, but each subject/group/etc. may be represented in multiple rows).

Only variables that were mean and standard deviation metrics were retained, according to instructions. This included meanFreq variables (as these are means measures), but not angle easures between mean measures (as these are measures of angles, not means).

The activities were transformed and labeled as a factor variable according to the "activity_labels.txt" file.

The variable names were labeled according to the "features.txt" file, with some modifications:
- "(" and ")" characters were removed
- "-" characters were replaced with "." in order to improve readability and for internal consistency for naming variables in the file
- the initial "t" on variable names was changed to "time" (and separated with a ".") for amore explicit variable name
- the initial "f" on variable names was changed to "freq" (and separated with a ".") for a more explicit variable name

Data were then transformed by taking the average of each measure by subject.id and activities. Again, the data were formatted into a long style (because it was straight forward to do so, and because R tends to handle long data more elegantly).

This tidy data set was then output to the tidy_data.txt file.

More detailed information about this process can be found in README.md.

## Data Description
The tidy_data.txt file is a space delimited text file. There is a header with the variable names in the first row. Numeric variables are stored without quotes and characters/factors are stored within double quotes "".

There are 180 rows of data (not included the header data) and 81 columns of data. Each row contains the data of 81 variables (separated by spaces).

The data are in long form - that is, each variable is only represented by a single column, and grouping variables are explicit. Note that the time- and frequency- domain features are fundamentally different, so grouping them into a long(er) format would not be appropriate.

## Variables
*Note*: The classes listed for the variables in the tidy_data.txt file are those that would be expected when loading the data into R using the defaults for read.table().

subject.id - class "integer", although this is an unorderable nominal variable, it is stored as an integer for simplicity - it is easily coerced as a factor, if desired, once loaded into R.
activities - class "factor", levels - "walking", "walking upstairs", "walking downstairs", "standing", "sitting", "laying"

Each of the following variables is the mean (therefore class "numeric"), by subjects and activities, of the associated variables from (the original data). Full details about the original variables can be found in the "features_info.txt" file in the "UCI HAR Dataset" folder. Since they are all means grouped by the same variables, there is no need to complicate the variable names further to explicitly state that they are all means (this would be excessive).

time.BodyAcc.mean.X
time.BodyAcc.mean.Y
time.BodyAcc.mean.Z
time.BodyAcc.std.X
time.BodyAcc.std.Y
time.BodyAcc.std.Z
time.GravityAcc.mean.X
time.GravityAcc.mean.Y
time.GravityAcc.mean.Z
time.GravityAcc.std.X
time.GravityAcc.std.Y
time.GravityAcc.std.Z
time.BodyAccJerk.mean.X
time.BodyAccJerk.mean.Y
time.BodyAccJerk.mean.Z
time.BodyAccJerk.std.X
time.BodyAccJerk.std.Y
time.BodyAccJerk.std.Z
time.BodyGyro.mean.X
time.BodyGyro.mean.Y
time.BodyGyro.mean.Z
time.BodyGyro.std.X
time.BodyGyro.std.Y
time.BodyGyro.std.Z
time.BodyGyroJerk.mean.X
time.BodyGyroJerk.mean.Y
time.BodyGyroJerk.mean.Z
time.BodyGyroJerk.std.X
time.BodyGyroJerk.std.Y
time.BodyGyroJerk.std.Z
time.BodyAccMag.mean
time.BodyAccMag.std
time.GravityAccMag.mean
time.GravityAccMag.std
time.BodyAccJerkMag.mean
time.BodyAccJerkMag.std
time.BodyGyroMag.mean
time.BodyGyroMag.std
time.BodyGyroJerkMag.mean
time.BodyGyroJerkMag.std
freq.BodyAcc.mean.X
freq.BodyAcc.mean.Y
freq.BodyAcc.mean.Z
freq.BodyAcc.std.X
freq.BodyAcc.std.Y
freq.BodyAcc.std.Z
freq.BodyAcc.meanFreq.X
freq.BodyAcc.meanFreq.Y
freq.BodyAcc.meanFreq.Z
freq.BodyAccJerk.mean.X
freq.BodyAccJerk.mean.Y
freq.BodyAccJerk.mean.Z
freq.BodyAccJerk.std.X
freq.BodyAccJerk.std.Y
freq.BodyAccJerk.std.Z
freq.BodyAccJerk.meanFreq.X
freq.BodyAccJerk.meanFreq.Y
freq.BodyAccJerk.meanFreq.Z
freq.BodyGyro.mean.X
freq.BodyGyro.mean.Y
freq.BodyGyro.mean.Z
freq.BodyGyro.std.X
freq.BodyGyro.std.Y
freq.BodyGyro.std.Z
freq.BodyGyro.meanFreq.X
freq.BodyGyro.meanFreq.Y
freq.BodyGyro.meanFreq.Z
freq.BodyAccMag.mean
freq.BodyAccMag.std
freq.BodyAccMag.meanFreq
freq.BodyBodyAccJerkMag.mean
freq.BodyBodyAccJerkMag.std
freq.BodyBodyAccJerkMag.meanFreq
freq.BodyBodyGyroMag.mean
freq.BodyBodyGyroMag.std
freq.BodyBodyGyroMag.meanFreq
freq.BodyBodyGyroJerkMag.mean
freq.BodyBodyGyroJerkMag.std
freq.BodyBodyGyroJerkMag.meanFreq

