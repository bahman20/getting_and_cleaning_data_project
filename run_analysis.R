#Clear data
rm(list=ls())

#Check if zip folder is already downloaded. If not, downloads it. If the folder is not already unzipped, it unzips the folder.
if (!file.exists("getdata_dataset.zip")){download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "getdata_dataset.zip")}  
if (!file.exists("UCI HAR Dataset")) {unzip("getdata_dataset.zip")}

#Read data from downloaded and unzipped text files
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")[,2]
features<-read.table("UCI HAR Dataset/features.txt")[,2]
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")

#Assign column names to subject_test and subject_train
colnames(subject_test)<-"subject_ID"
colnames(subject_train)<-"subject_ID"

#Assign column names to test and train data sets
colnames(x_test)<-features; 
colnames(y_test)<-"activity_ID"
colnames(x_train)<-features; 
colnames(y_train)<-"activity_ID"

#Bind subject_ID, data and activity ID columns for both test and train data sets
train<-cbind(subject_train, x_train, y_train)
test<-cbind(subject_test, x_test, y_test)

#Merge all data (test and train)
all_data<-rbind(train,test)

#save column names of all_data to column_names
column_names<-names(all_data)

#Eliminate columns whose names do not contain strings "mean()" and "std()"
filtered_data<-all_data[(grepl("activity..",column_names) | grepl("subject..",column_names) | grepl("-mean[()]",column_names) | grepl("-std[()]",column_names) )==TRUE]

#Convert activity_ID and subject_ID to factors
filtered_data$activity_ID<-factor(filtered_data$activity_ID, levels = seq(1:6), labels = activity_labels)
filtered_data$subject_ID<-as.factor(filtered_data$subject_ID)

#Melt data and create the desired tidy data
filtered_data_melt<-melt(filtered_data, id = c("subject_ID", "activity_ID"))
tidy_data<-dcast(filtered_data_melt, subject_ID + activity_ID ~ variable, mean)

#Save tidy data into text file
write.table(tidy_data, "tidy_data.txt", row.name=FALSE);
