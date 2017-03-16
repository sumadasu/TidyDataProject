filepath variable stores the path in which you have the data files and scripts
subject_train : this variable reads the subject train data and which is under /train/subject_train.txt
subject_test : this variable reads the subject train data and which is under /train/subject_train.txt

# these two variables read the activity data which is under /train/y_train.txt  /test/y_test_txt
Activity_train
Activity_test 

# these two variables read the activity data which is under /train/x_train.txt  /test/x_test_txt
traindata
testdata
# stores merged subject train and test data
subjectdata
# store merged activity and test train
Activitydata 

# merges test and train data
datatable

# reads the features.txt file which has 33 measurements
features
# reads the activiy file
activityLabels
# stores megred activity and ubject data
SubjectActivity
# reads mean and std from the features data
Mean_Std
# output file from  the tidy data set
TidyData.txt
