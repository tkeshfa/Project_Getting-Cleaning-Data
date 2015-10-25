# fetching the data from the internet
library("dplyr")
url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,des="data.zip",mode="wb")
unzip ("data.zip", exdir = ".")

# reading the data into variables

setwd("./UCI HAR Dataset")
activity_labels<-read.table("activity_labels.txt",col.names=c("Act_id","Act_name"))
features<-read.table("features.txt",col.names=c("Feat_id","Feat_name"))

## Reading Test data

setwd("./test")
y_test<-read.table("y_test.txt",col.names="y_id")
x_test<-read.table("X_test.txt")
subject_test<-read.table("subject_test.txt",col.names=c("sub_id"))

setwd("./Inertial Signals")
body_acc_x_test<-read.table("body_acc_x_test.txt")
body_acc_y_test<-read.table("body_acc_y_test.txt")
body_acc_z_test<-read.table("body_acc_z_test.txt")
body_gyro_x_test<-read.table("body_gyro_x_test.txt")
body_gyro_y_test<-read.table("body_gyro_y_test.txt")
body_gyro_z_test<-read.table("body_gyro_z_test.txt")
total_acc_x_test<-read.table("total_acc_x_test.txt")
total_acc_y_test<-read.table("total_acc_y_test.txt")
total_acc_z_test<-read.table("total_acc_z_test.txt")

## Reading training data

setwd("../../train")
y_train<-read.table("y_train.txt",col.names="y_id")
x_train<-read.table("X_train.txt")
subject_train<-read.table("subject_train.txt",col.names=c("sub_id"))

setwd("./Inertial Signals")
body_acc_x_train<-read.table("body_acc_x_train.txt")
body_acc_y_train<-read.table("body_acc_y_train.txt")
body_acc_z_train<-read.table("body_acc_z_train.txt")
body_gyro_x_train<-read.table("body_gyro_x_train.txt")
body_gyro_y_train<-read.table("body_gyro_y_train.txt")
body_gyro_z_train<-read.table("body_gyro_z_train.txt")
total_acc_x_train<-read.table("total_acc_x_train.txt")
total_acc_y_train<-read.table("total_acc_y_train.txt")
total_acc_z_train<-read.table("total_acc_z_train.txt")

# Q1: merging training and test dataset

body_acc_x_all<-rbind(body_acc_x_train,body_acc_x_test)
body_acc_y_all<-rbind(body_acc_y_train,body_acc_y_test)
body_acc_z_all<-rbind(body_acc_z_train,body_acc_z_test)
body_gyro_x_all<-rbind(body_gyro_x_train,body_gyro_x_test)
body_gyro_y_all<-rbind(body_gyro_y_train,body_gyro_y_test)
body_gyro_z_all<-rbind(body_gyro_z_train,body_gyro_z_test)
total_acc_x_all<-rbind(total_acc_x_train,total_acc_x_test)
total_acc_y_all<-rbind(total_acc_y_train,total_acc_y_test)
total_acc_z_all<-rbind(total_acc_z_train,total_acc_z_test)
x_all<-rbind(x_train,x_test)
y_all<-rbind(y_train,y_test)
subject_all<-rbind(subject_train,subject_test)
har_dataset<-cbind(subject_all,y_all,x_all,body_acc_x_all,body_acc_y_all,body_acc_z_all,body_gyro_x_all,body_gyro_y_all,body_gyro_z_all,total_acc_x_all,total_acc_y_all,total_acc_z_all)
har_dataset<-tbl_df(har_dataset)

# Q2: Extract the mean & std measurments only from x_all into meas_mean_std variables

features<-tbl_df(features)
ft_idx_mean_std<-filter(features,grepl("mean|std",Feat_name)) %>% select(Feat_id)
ft_name_mean_std<-filter(features,grepl("mean|std",Feat_name)) %>% select(Feat_name)
ft_idx_mean_std<-c(do.call("cbind",ft_idx_mean_std))

meas_mean_std<-select(x_all,ft_idx_mean_std)
meas_mean_std<-cbind(subject_all,y_all,meas_mean_std)
meas_mean_std<-tbl_df(meas_mean_std)

#  Q3: Uses descriptive activity names to name the activities in the data set

meas_mean_std$y_id<-meas_mean_std$y_id%>%factor(level=activity_labels[,1],labels=activity_labels[,2])

# Q4: Appropriately labels the data set with descriptive variable names.

colnames(meas_mean_std)<-c("sub_id","act_id",as.vector((t(as.matrix(ft_name_mean_std)))))

# Q5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

newdataset<-meas_mean_std %>% group_by(act_id,sub_id) %>% summarize_each(funs(mean))

# wrtie table.

setwd("../../")
write.table(newdataset,file="tidy_data_set.txt",row.name=FALSE)
