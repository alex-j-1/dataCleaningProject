#unzip the .zip file with all the data into your default R working directory.

#read the files you care about into R, using the read.table function
x_test <- read.table("x_test.txthead")
y_train <- read.table("y_train.txt")
subject_test <- read.table("subject_test.txt")
subject_train <- read.table("subject_train.txt")
features <- read.table("features.txt")
x_train <- read.table("x_train.txt")
y_test <- read.table("y_test.txt")
activity_labels <- read.table("activity_labels.txt")


#strip out the "()", ",", & "-" from the features data
features$V2 <- gsub(",","_",features$V2)
features$V2 <- gsub("-","__",features$V2)
features$V2 <- gsub("\\(\\)", "", features$V2)

#add the activity as a column for both test and training data
test <- cbind(x_test,y_test)
train <- cbin(x_train,y_train)

#add the subject as a column for both test and training data
test <- cbind(test, subject_test)
train <- cbind(train, subject_train)

#add the names to the 2 data frames, from the feature vector
names(train) <- features$V2
names(test) <- features$V2

#we only care about variables which involve mean or std deviation
meanOrStdLogical <- grepl("mean|std", names(test), ignore.case=TRUE)

#we need to modify the last two values of the logical vector to be true,
#because they are actual the activity/subject columns.
meanOrStdLogical[[563]] <- meanOrStdLogical[[562]] <- TRUE

#chop out the non-mean/std of the training data
train <- train[,meanOrStdLogical]

#chop out the non-mean/std of the test data
test <- test[,meanOrStdLogical]

#change the last two column names for the test data, because they never had a name
colnames(test)[87] <- "activity"
colnames(test)[88] <- "subject"

#change the last two column names for the training data, because they never had a name
colnames(train)[87] <- "activity"
colnames(train)[88] <- "subject"

#for each subject: for each activity, calculate the mean of each variable.
test <- test %>% group_by(activity,subject) %>% summarise_each(funs(mean))
train <- train %>% group_by(activity,subject) %>% summarise_each(funs(mean))

#Combine the test and training data
result <- rbind(test,train)

#Sort the result by subject.
result <- result[order(result$subject),]

#use the fully qualified (English) descriptions for the activity variable.
activityCol <- gsub("1","WALKING", activityCol)
activityCol <- gsub("2","WALKING_UPSTAIRS", activityCol)
activityCol <- gsub("3","WALKING_DOWNSTAIRS", activityCol)
activityCol <- gsub("4","SITTING", activityCol)
activityCol <- gsub("5","STANDING", activityCol)
activityCol <- gsub("6","LAYING", activityCol)
result$activity <- activityCol

#write the data into a separate file
write.table(result, file="final_result.txt", row.names=FALSE)