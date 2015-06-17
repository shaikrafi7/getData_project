The objective of the project is to return a tidy data from the raw data collected from the accelerometers from the Samsung Galaxy S smartphone, while 30 subjects performed six different physical activites. The raw data was randomly partitioned into train(70%) and test sets(30%).

Data was downloaded from the URL provided in the assignment and unzipped. Readme file in the folder describes contents of various files included in the folder

A run_analysis.R script was created to perform the tasks given in the assignment.

Task 1: Raw train and test data was loaded into R using read.table into variables trainData and test data, respectively. Then were merged using rbind and stored in allData.

Task 2: features.txt was manually observed to identify columns with mean and std variables. The variables with mean() and std() at end of the variable names were selected and a vector called meanStdCols was build. allData was subsetted with meanStdCols and stored into meanStdData.

Task 3: Subject numbers data from y_train.txt and y_test.txt were loaded into R and merged with rbind and stored in allLbls. Then it was merged with meanStdData via cbind and stored in meanStdLblsData. Activity descriptive names available in activity_labels.txt was loaded and stored in activityLabels. A new row of activity descriptive name was added to meanStdLblsData where activity number in meanStdLblsData matched activity number in activityLabels. Then allLbls column was dropped from meanStdLblsData.

Task 4: features.txt was loaded into R and subsetted by meanStdCols and stored in meanStdFeatures which was then added to meanStdLblsData via names function.The activity descriptive name column was named as "activity" via colnames function.

Task 5: Subject data for each of the observations was loaded and merged into allSubjs, and merged with meanStdLblsData. The new column was named "subjects". Average of each variable for each activity and each subject was calculated by grouping the data by "activity" and "subjects" and using summarise_each function with a chaining operator. 


