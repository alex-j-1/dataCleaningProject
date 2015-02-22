The following is the methodology I used to tidy the data. It was a 10-step process. More detailed descriptions are available in the the run_analysis.R file, as comments.

Step 1: Read the following files into R: features, x_test, x_train, y_test, y_train, subject_test, subject_train, activity_labels.txt

Step 2: strip out the "()", ",", & "-" from the features data

Step 3: add the activity as a column for both test and training data

Step 4:add the subject as a column for both test and training data

Step 5: add the subject as a column for both test and training data

Step 6: add the names to the 2 data frames, from the feature vector

Step 7: Extract only the variables which involve calculation of mean and std. deviation

Step 8: for each subject: for each activity, calculate the mean of each variable.

Step 9: Sort the final result by subject

Step 10: Write the final result to a file, called "final_result.txt"
