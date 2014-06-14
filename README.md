# README File for the Tidy Data Set Creation Course Project
===========================================================

## Introduction
*Author*: Stephan E. Fabregas

*Class*: Getting and Cleaning Data, Coursera, June 2014

*Notes*: The R script was created and tested with R 3.1.0 on Linux Mint 14

This file describes the process for creating the tidy data set from the Human Activity Recognition Using Smartphones data set according to the instructions provided for the Course Project for this class.

## Files
README.md - this file...

CodeBook.md - a detailed description of the tidy data set

run_analysis.R - the script for loading in the raw data, cleaning it, and outputing the tidy data set. A detailed description of how this script functions follows

tidy_data.txt - the output of the run_analysis.R script, contents of this file are described in detail in the CodeBook.md

## Data Cleaning Process
In R, the session will load a number of variables as a result of running the run_analysis.R script, as well as creating a file with containing the tidy data set. Each such "script variable" is described below. These variables can be used to run further analyses or to check the performance of this script while in an active R session.

### Importing the data
There is a single script file for this analysis (run_analysis.R), in the root of this repository, which can be used to download the data, process it, and write out a tidy data set to a .txt file (according to the instructions on the course website). Details about this process are presented here.

Raw data for this assignment can be downloaded [here](https://d396qusza40orc.cloudfront.net/getData%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) on 2014-06-12. This script was run with the first section of code uncommented in order to download the raw data and process it. The instructions indicate that this script should function as long as the raw data are in the current working directory. In this case, it is assumed that the unzipped data are contained in a folder called "UCI HAR Dataset" which is in the current working directory. In order to allow for both these options, the code is provided, commented out, that would download the data, unzip the contents, and place them into the appropriate folder.

Since the "run_analysis.R" script is in the root directory of this repository, when this script is run, the current working directory needs to point to "UCI HAR Dataset" which contains the raw data.

Then, load in all the necessary data files to begin processing, including the subject ids, activity data, and raw data (but not the raw raw inertial data) for both the test and training set data.

### Importing the data: script variables
- test.subject.id - data frame, 1 integer column, 2947 rows, the test data subject ids
- test.data - data frame, 561 numeric columns, 2947 rows, the test data variables
- test.activities - data frame, 1 integer column, 2947 rows, the test data activity list
- train.subject.id - data frame, 1 integer column, 2947 rows, the training data subject ids
- train.data - data frame, 561 numeric columns, 2947 rows, the training data variables
- train.activities - data frame, 1 integer column, 2947 rows, the training data activity list

### Merging Data
The rbind() function is used to combine the test and training data, once for each of the subject ids, data variables, and activities lists. Since the subject ids and activities lists data are currently data frames, when merged in this way, the variable name is lost, so the names() function is used to add them back in.

Since two separate datasets are being merged, information may be lost when combining them into a single data set if care is not taken. A new variable is created to track which rows came from which data set (test or training).

Rather than use merge(), the data from the different variables are combined using the cbind() function because there is no "key" variable, and the cbind function is simpler to comprehend and implement.

### Merging data: script variables
subject.id - data frame, 1 integer column, 10299 rows, merged subject ids

activities - data frame, 1 integer column, 10299 rows, merged activities lists

which.set - factor, 10299 rows, 2 levels, key to source of data as test or training set

### Extract mean and standard deviation variables
The current working directory is still set to "UCI HAR Dataset", load the "features.txt" file to assist is selecting variables that are for means and standard deviations measures, and later, in naming the variables appropriately.

The grep() function is used to identify rows in the features files that contain "-mean" or "-std", and store the information in the columns variable. This includes measures of meanFreq, but excludes the angle measures on mean variables, as these are actually measures of angles, not means.

With the proper variables identified, we extract those columns, by index, from the combined data set. Note that the data set contains two columns to the left of the variables in question (namely, subject id and activity), so the columns variable needs to be adjusted to index the correct columns to extract. Note also that the variables "subject.id", "activity", and "which.set" need to be extracted as well.

### Extract mean and standard deviation variables: script variables
vars - data frame, 2 columns (1 integer, 1 factor), 561 rows, raw data variable names

columns - integer, 79 rows, indices of raw data variables that are measures of means or standard deviations

### Activity factor labels
Recast the activities variable in the clean data set as a factor (note that this does not affect the script variable "activities"). As a factor, only the levels need now be labeled appropriately.

To get appropriate labels for the levels, the second column of the "activity_labels.txt" file is loaded as lower case characters. "_" characters are replaced with spaces, then the appropriate names are used to label the appropriate levels in the activities variable of the clean data set.

### Activity factor labels: script variables
act.levels - character, 6 rows, names of the activities to use as factor labels

### Data variable names
Recast the "vars" raw data variable names as characters rather than factors in order to use grep to clean up the variable names for use. All parentheses are removed, "-" is replaced by "." (for naming convention consistency within the script), and the leading "t" or "f" are explicitly stated as "time." or "freq." (since this is more explicit and reduces the number of times one needs to look up the information before retaining it).

The clean data set variable names are then applied to the data.

### Data variable names: script variables
new.names - character, 79 rows, the clean variable names for the original data variables

data - data frame, 82 columns (1 integer, 2 factor, 79 numeric), the clean data set

### Create the tidy data set
Move back into the root directory for the repository in order to place the tidy data set inthe correct location.

The aggregate() function is used to create a long version of the tidy data efficiently and effectively, with the mean of each data variable grouped by both subject and activity. Long data is preferred in this case not because it is technically more "tidy" than wide data, but because the process to do so is very efficient, and R, in general, is better at handling long data through the use of various grouping variables (such as tapply).

The grouping variable names ("subject.id", and "activities") are added back in after being lost in the aggregate command, and the tidy data set is ready for use.

Note that the which.set variable is lost as data are combined between the test and training sets in order to calculate the variable means by subject and activity.

The tidy data is then output to the "tidy_data.txt" file in the rooty directory of the repository as per the standard use of the defaults for the write.table() function, except with row.names set to FALSE.

### Create the tidy data set: script variables
tidy_data - data frame, 81 columns (1 integer, 1 factor, 79 numeric), 180 rows, the tidy data set

### Tidy Data Code Book
For details about the data and variables in the tidy data set, see the CodeBook.md file.
