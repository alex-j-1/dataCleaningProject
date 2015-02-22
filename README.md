Step 1: Read the following files into R: features, x_test, x_train, y_test, y_train, subject_test, subject_train, activity_labels.txt

Step 2: Each row in features.txt represents a column name for both x_test.txt and x_train.txt.
So, the task is to make the features.txt column the names() row for both data frames.

Step 3: We want to combine the x_test data and x_train data. Just place one on top of the other. a function like rbind() is sufficient here.
