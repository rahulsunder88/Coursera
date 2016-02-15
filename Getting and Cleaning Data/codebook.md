### Code book for run_analysis.R

* Combine the datasets Train_X, test_X,similarly combine Train_Y and Test_Y and TrainSubject and Test Subject
  + bindData is combination of Train_X, test_X
  + bindLabel is combination of Train_Y and Test_Y 
  + joinSubject is combination of TrainSubject and Test Subject
* Read the features.txt, extract the mean and the Standar deviation in the given datasets and store it in bindData.
  + bindData has been included with another column containing mean/std.
* Read the activity file and store it in the activity variable.
* Tranform bind Label according to activity data frame.
* write the output to mergeddata_data.txt
* Generate an independent file with the average of each variable for each activity and each subject.