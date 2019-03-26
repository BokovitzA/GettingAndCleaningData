## This code was written on 3/25/2019 for the Coursera Data Science Certification
## This code will perform an analysis on a study done using smartphones to match
## humans based on their movements
## Information can be found here: 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Load the dyplr and data.table libraries to make it easier 
## to work with the data set
library(dplyr)
library(data.table)

## Download the file to the current working directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, paste(getwd(), "/zippedData.zip", sep = ""))
unzip(paste(getwd(),"/zippedData.zip", sep = ""))

## Load all of the data files to memory
trainSubjectIndex <- read.table(paste(getwd(),"/UCI HAR Dataset/train/","subject_train.txt", sep = ""))
trainObservations <- read.table(paste(getwd(),"/UCI HAR Dataset/train/","x_train.txt", sep = ""))
trainActivityFactors <- read.table(paste(getwd(),"/UCI HAR Dataset/train/","y_train.txt", sep = ""))

testSubjectIndex <- read.table(paste(getwd(),"/UCI HAR Dataset/test/","subject_test.txt", sep = ""))
testObservations <- read.table(paste(getwd(),"/UCI HAR Dataset/test/","x_test.txt", sep = ""))
testActivityFactors <- read.table(paste(getwd(),"/UCI HAR Dataset/test/","y_test.txt", sep = ""))

obsColumnNames <- read.table(paste(getwd(),"/UCI HAR Dataset/","features.txt", sep = ""))
activityLabels <- read.table(paste(getwd(),"/UCI HAR Dataset/","activity_labels.txt", sep = ""))

## Add the column names for the observation and merge together
## the subjects and the activies they were performing during the obs
colnames(activityLabels) <- c("factor_id","activity")

colnames(trainSubjectIndex) <- "subject"
colnames(trainActivityFactors) <- "factor_id"
colnames(trainObservations) <- obsColumnNames$V2

colnames(testSubjectIndex) <- "subject"
colnames(testActivityFactors) <- "factor_id"
colnames(testObservations) <- obsColumnNames$V2

trainCombined <- data.table(trainObservations)
trainCombined <- cbind(trainSubjectIndex,
                      inner_join(trainActivityFactors,
                                 activityLabels,
                                 c("factor_id" = "factor_id")) ,
                      trainCombined)

testCombined <- data.table(testObservations)
testCombined <- cbind(testSubjectIndex,
                      inner_join(testActivityFactors,
                                 activityLabels,
                                 c("factor_id" = "factor_id")) ,
                      testCombined)

## Combine both data sets
allObservations <- rbind(testCombined,trainCombined)

## Subsetting the combined data to limit the data to only include
## the subject, activity being performed, and fields related to 
## the mean or standard deviation from the original data
subsetData <- allObservations[,grepl("subject|activity|mean|std",colnames(allObservations))]

## Group the data by subject and activity so that the average
## can be taken of the observations
groupedData <- group_by(subsetData, subject, activity)
finishedData <- summarize_all(groupedData,list(mean))

## Write out the finalized summary as a text file
write.table(finishedData, 
            row.names = FALSE,
            file = paste(getwd(),"/summary_data.txt", sep = ""))