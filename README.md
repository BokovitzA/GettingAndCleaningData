# GettingAndCleaningData
A repo for the Getting and Cleaning Data project submissions

# Processing Steps

### Step One - Download the file
The code downloads and unzips the file into the user's
current R working directory.

### Step Two - Read in the data files
The code will then go through and import the files needed.  
* X_test.txt and X_train.txt files that have the observations  
* subject_test.txt and subject_train.txt files that contain the subject IDs
that correlate with the observations  
* Y_test.txt and Y_train.txt files that list out what activity the subject was doing during the observations using an integer value of 1-6  
* activity_labels.txt provides a mapping for the 1-6 integers to a descriptive explanation of the activity  
* features.txt has the names for the observations in the X_test and X_train files

### Step Three - Combine the data
The code will then go through and make sure that each column has a descriptive name instead of the defaults provided.  It will then combine the subject, activity, activity labels, and observations into a data table for both the test and train populations.  After that it will combine both data sets into one.

### Step Four - Subset the data
The Coursera assignment requests a that the tidied data be subset such that it only includes fields for the subject, the activity being performed, and any fields containing either average or standard deviations.

### Step Five - Final report
The assignment requested a data file containing the mean of each of observations for each permutation of subject and activity.  The code will then call the dyplr group_by() and summerize_all() functions to accomplish this. Finally, the code will write out a text file called summary_data.txt to the user's working directory.