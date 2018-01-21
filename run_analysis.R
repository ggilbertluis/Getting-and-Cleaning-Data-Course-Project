library("data.table")

##-----------------read all data-----------------
##read activity_labels.txt
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")[,2]

##read features.txt
features <- read.table("./data/UCI HAR Dataset/features.txt")[,2]

##remove all unnecessary characters in features to be used as colnames
features<- gsub("\\(","",features)
features<- gsub("\\)","",features)
features<- gsub("-","",features)
features<- gsub(",","_",features)

##read test data
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
names(X_test) = features
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
names(subject_test) = "Volunteer"

##read train data
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
names(X_train) = features
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
names(subject_train) = "Volunteer"


##-----------------Data manipulation-----------------
##Search for mean or std in features
meanStdFeatures <- grepl("mean|std", features)

##get only mean and std in test and train
X_test = X_test[,meanStdFeatures]
X_train = X_train[,meanStdFeatures]

##add column activity_labels levels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("ActivityId", "Activity")
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("ActivityId", "Activity")

##merge X and Y data
testData <- cbind(as.data.table(subject_test), y_test, X_test)
trainData <- cbind(as.data.table(subject_train), y_train, X_train)

##merge test and train data
bindData = rbind(testData, trainData)

##melt bindData
id = c("Volunteer", "ActivityId", "Activity")
measure_vars = setdiff(colnames(bindData), id)
melted = melt(bindData, id = id, measure.vars = measure_vars)

##use dcast function to apply mean into the finalData
finalData = dcast(melted, Volunteer + Activity ~ variable, mean)

##write into a csv file
write.csv(finalData, file = "./data/UCI HAR Dataset/UCIHARDataset.csv")
