  ###1.Merges the training and the test sets to create one data set.
  #load train and test data into R
  trainData<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
  testData<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
  #merge the datasets
  allData<-rbind(trainData,testData)
  
  ###2.subset meanStdCols from allData
  # create a vector of mean and std columns with mean and std in variable name at end in features.txt
  meanStdCols<-c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543)
  #subset the dataset
  meanStdData<-allData[,meanStdCols]
  
  ###3. Uses descriptive activity names to name the activities in the data set
  #load train and test labels
  trainLbls<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train//y_train.txt")
  testLbls<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test/y_test.txt")
  
  #merge labels into one vector
  allLbls<-rbind(trainLbls,testLbls)
  
  #merge labels with merged dataset
  meanStdLblsData<-cbind(meanStdData,allLbls) 
    
  #load activity labels
  activityLabels<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
  
  #merge activity labels to the main dataset
  meanStdLblsData[meanStdLblsData[,67]==1,68]<-as.character(activityLabels[1,2])
  meanStdLblsData[meanStdLblsData[,67]==2,68]<-as.character(activityLabels[2,2])
  meanStdLblsData[meanStdLblsData[,67]==3,68]<-as.character(activityLabels[3,2])
  meanStdLblsData[meanStdLblsData[,67]==4,68]<-as.character(activityLabels[4,2])
  meanStdLblsData[meanStdLblsData[,67]==5,68]<-as.character(activityLabels[5,2])
  meanStdLblsData[meanStdLblsData[,67]==6,68]<-as.character(activityLabels[6,2])
  
  #Drop the labels column
  meanStdLblsData<-meanStdLblsData[,-67]
  
  ###4. Appropriately labels the data set with descriptive variable names.
  #Load features
  features<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//features.txt")
  
  #subset features with meanStdCols
  meanStdFeatures<-as.character(features[meanStdCols,2])
  
  #Add column names to the merged dataset
  names(meanStdLblsData)<-meanStdFeatures
  
  #label the new column added
  colnames(meanStdLblsData)[67]<-"activity"
  
  ###5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  #load subjects 
  trainSubjs<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train//subject_train.txt")
  testSubjs<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test/subject_test.txt")
  
  #merge subjects into one vector
  allSubjs<-rbind(trainSubjs,testSubjs)
  
  #merge subjects with merged dataset
  meanStdLblsData<-cbind(meanStdLblsData,allSubjs) 
  
  #label the new column added
  colnames(meanStdLblsData)[68]<-"subjects"
  
  # calculate average of each variable for each activity and each subject
  tidyData<-meanStdLblsData %>%
    group_by(activity,subjects) %>%
    summarise_each(funs(mean)) 
  
  #Write the tidy data
  write.table(tidyData,"tidyData.txt",row.names = FALSE)
