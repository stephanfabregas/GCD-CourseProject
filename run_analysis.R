# Uncomment the following to download the file from the source website
# and unzip the data into its constituent files
# The files have already been added to the repository (2014-06-12), so
# this section can be skipped if utilizing those files
##data.source <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##zip.file <- "zipfile.zip"
##download.file(data.source,zip.file,method="wget")
##unzip(zip.file)

# Move to the data file directory to get the data
setwd("./UCI HAR Dataset/")

# Load in the data from each of the necessary files
# Loading in the data (X_test & X_train) can take a while
test.subjects <- read.table("test/subject_test.txt")
test.data <- read.table("test/X_test.txt",nrows=2947)
test.activities <- read.table("test/y_test.txt")
train.subjects <- read.table("train/subject_train.txt")
train.data <- read.table("train/X_train.txt",nrows=7352)
train.activities <- read.table("train/y_train.txt")

# Move back to the parent directory
setwd("../")

# Merge the test and train data into a single data set
subjects <- rbind(test.subjects, train.subjects)
data <- rbind(test.data, train.data)
activities <- rbind(test.activities, train.activities)

# Since we're merging data to make a long dataset, create
# a label variable to retain the information
which.set <- factor(c(rep(1, nrow(test.data)), rep(2, nrow(train.data))),
              labels=c("test","train"))

# Extract only the measurements on the mean and standard deviation
# for each measurement
# Indices of columns of measurements of mean and standard deviation
# in the data set
columns <- c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,
             240:241,253:254,266:271,294:296,345:350,373:375,424:429,
             452:454,503:504,513,516:517,526,529:530,539,542:543,552)

data <- data[,columns]

# Use descriptive activity names to name the activities in the data set
activities <- as.factor(activities[,1])
levels(activities) <- c("Walking", "Walking Upstairs",
                        "Walking Downstairs", "Sitting", "Standing",
                        "Laying")

# Appropriately label the data set with descriptive variable names
vars <- read.table("features.txt")
names(data) <- as.character(vars[columns,2])

# Create a second, independent tidy data set with the average of each
# variable for each activity and each subject


