# Uncomment the following to download the file from the source website
# and unzip the data into its constituent files
# The files have already been added to the repository (2014-06-12), so
# this section can be skipped if utilizing those files

## data.source <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## zip.file <- "zipfile.zip"
## download.file(data.source,zip.file,method="wget")
## unzip(zip.file)

# Move to the data file directory to get the data
setwd("./UCI HAR Dataset/")

# Load in the data from each of the necessary files
# Loading in the data (X_test & X_train) can take a while
test.subject.id <- read.table("test/subject_test.txt")
test.data <- read.table("test/X_test.txt",nrows=2947)
test.activities <- read.table("test/y_test.txt")
train.subject.id <- read.table("train/subject_train.txt")
train.data <- read.table("train/X_train.txt",nrows=7352)
train.activities <- read.table("train/y_train.txt")

# Merge the test and train data into a single data set
subject.id <- rbind(test.subject.id, train.subject.id)
names(subject.id) <- "subject.id"
data <- rbind(test.data, train.data)
activities <- rbind(test.activities, train.activities)
names(activities) <- "activities"

# Create a label variable to retain the information about which data
# set each row came from
which.set <- factor(c(rep(1, nrow(test.data)),
                      rep(2, nrow(train.data))),
                    labels=c("test","train"))

# Actually merge all the relevant data into a single data frame
data <- cbind(subject.id, activities, data, which.set)

# Extract only the measurements on the mean and standard deviation
# for each measurement
# Variable "columns" is indices of columns of measurements of mean
# and standard deviation in the data set
vars <- read.table("features.txt")
columns <- grep("-mean|-std",vars[,2])

data <- data[,c(1, 2, columns+2, ncol(data))]

# Use descriptive activity names to name the activities in the data set
data$activities <- as.factor(activities[,1])
act.levels <- tolower(levels(read.table("activity_labels.txt")[,2]))
act.levels <- sub("_", " ", act.levels)
levels(data$activities) <- c(act.levels[4],act.levels[6],act.levels[5],
                        act.levels[2],act.levels[3],act.levels[1])

# Appropriately label the data set with descriptive variable names
new.names <- as.character(vars[columns,2])
new.names <- gsub("[()]", "", new.names)
new.names <- gsub("[-]", ".", new.names)
new.names <- gsub("^t", "time.", new.names)
new.names <- gsub("^f", "freq.", new.names)
names(data) <- c("subject.id", "activities", new.names, "which.set")

# Move back to the parent directory
setwd("../")

# Create a second, independent tidy data set with the average of each
# variable for each activity and each subject
tidy.data <- aggregate(data[, 3:(ncol(data)-1)],
                       by=list(data$subject.id, data$activities),
                       mean)

# The aggregate function output does not retain the names of the
# grouping variables, so add them back in
names(tidy.data)[1:2] <- c("subject.id", "activities")

# Write out the tidy data set to file
outfile <- "./tidy_data.txt"
write.table(tidy.data, outfile, row.names=FALSE)
