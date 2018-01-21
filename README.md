# Getting and Cleaning Data Course Project
## Instructions: 
You should create one R script called run_analysis.R that does the following.

	1. Merges the training and the test sets to create one data set.
	2. Extract only the measurements on the mean and standard deviation for each measurement.
	3. Uses descriptive activity names to name the activities in the data set.
	4. Appropriately label the data set with descriptive variable names.
	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to RUN the run_analysis.R file

	1. Download the data source and paste it in your working directory.
	2. Paste the run_analysis.R file in your working directory.        
    3. Install data.table package
	4. Run source("run_analysis.R"), then it will generate a csv file names UCIHARDataset.csv the UCI HAR Dataset folder.

## How does the code work

	1. Read all the data under the UCI HAR Dataset folder.
	2. Clean all the data by:	
		a. Extracting the measurements on the mean and standard deviation only.
		b. Merging the training and the test sets to create one data set from the dataset folder.
		c. Tidying up the data using melt and dcast functions.		
	3. Save the clean data in a CSV file named UCIHARDataset.csv.