# path to the local directory where the data files are stored
filepath <- "C:/Users/suma/Desktop/Data science specialization/Cleaning data with R/data/UCI HAR Dataset"
filepath
# installing necessary libraries
library(dplyr)
library(data.table)
library(tidyr)
# reading the test and training data set for subjects
subject_train<-tbl_df(read.table(file.path(filepath,"train","subject_train.txt")))
subject_test <- tbl_df(read.table(file.path(filepath,"test","subject_test.txt")))
View(subject_train)
View(subject_train)
#read the data from test and train activity files
Activity_train <- tbl_df(read.table(file.path(filepath, "train", "y_train.txt")))
Activity_test <- tbl_df(read.table(file.path(filepath, "test", "y_test.txt")))
View(Activity_train)
View(Activity_test)
# reading the the data files that contain the actual data
traindata <-tbl_df(read.table(file.path(filepath, "train", "x_train.txt")))
View(traindata)
testdata <-tbl_df(read.table(file.path(filepath, "test", "x_test.txt")))
View(testdata)
# merging subject data for test and train groups
subjectdata<-rbind(subject_train,subject_test)
View(subjectdata)
# Assign the header line to the subject data
setnames(subjectdata,"V1","subject")
# merging test and train activity data
Activitydata <-rbind(Activity_train,Activity_test)
# assign header line to the activity data
setnames(Activitydata,"V1","ActivityNum")
View(Activitydata)
# merge test and train data
datatable<-rbind(traindata,testdata)
View(datatable)
#Read features data into a data frame
features <- tbl_df(read.table(file.path(filepath, "features.txt")))
View(features)
# assign headers to the features data
setnames(features,names(features),c("FeatureNum","FeatureName"))
View(features)
colnames(datatable)<-features$FeatureName
View(features)
# read data with activity labels and assign headers to the data
activityLabels<- tbl_df(read.table(file.path(filepath, "activity_labels.txt")))
View(activityLabels)
setnames(activityLabels, names(activityLabels), c("ActivityNum","ActivityName"))
SubjectActivity<-cbind(subjectdata,Activitydata)
View(SubjectActivity)
datatable<-cbind(SubjectActivity,datatable)
View(datatable)
# extracting mean and std
Mean_Std <-grep("mean\\(\\)|std\\(\\)",features$FeatureName,value =TRUE)
Mean_Std
# reading mean and standard deviation data and adding subect and activity num to the data
Mean_Std <- union(c("subject","ActivityNum"),Mean_Std)
View(Mean_Std)
datatable <-subset(datatable,select = Mean_Std)
View(datatable)
# Enter activity name to the data table
datatable <- merge(activityLabels, datatable , by="ActivityNum", all.x=TRUE)
View(datatable)
datatable$ActivityName <- as.character(datatable$ActivityName)
datatable$ActivityName <- as.character(datatable$ActivityName)
dataAggr<- aggregate(. ~ subject - ActivityName, data = datatable, mean) 
View(dataAggr)
datatable<- tbl_df(arrange(dataAggr,subject,ActivityName))
View(datatable)
head(str(datatable),2)
names(datatable)<-gsub("BodyBody","Body",names(datatable))
View(datatable)
# changing labels of the dataset
names(datatable)<-gsub("std()","SD",names(datatable))
names(datatable)<-gsub("mean()","MEAN",names(datatable))
names(datatable)<-gsub("^t", "time", names(datatable))
names(datatable)<-gsub("^f", "time", names(datatable))
names(datatable)<-gsub("ACC", "Accelerometer", names(datatable))
names(datatable)<-gsub("Gyro", "Gyroscope", names(datatable))
names(datatable)<-gsub("Mag", "Magnitude", names(datatable))
head(str(datatable),6)
Writing the tidy data set TidyData.txt file
write.table(datatable,"TidyData.txt",row.name = FALSE)