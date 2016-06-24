# getting_and_cleaning_data_project
Getting and cleaning data course project

The run_analysis.R file does the following:


1- Clears the data and vriables loaded into R.

2- Checks if zip folder is already downloaded. If not, downloads it. If the folder is not already unzipped, it unzips the folder.
3- Reads data from downloaded and unzipped text files. It reads the test and train data sets along with features, activities and        subject IDs for test and train datasets. 
4- Assigns descriptive column names to subject_test and subject_train.
5- Assigns descriptive column names to test and train data sets.
6- Bind subject_ID, data and activity ID columns for both test and train data sets.
7- Merges all data (test and train).
8- Saves column names of all_data to column_names.
9- Eliminates columns whose names do not contain strings "mean()" and "std()".
10- Converts activity_ID and subject_ID to factors.
11- Melts data and create the desired tidy data.
12- Saves tidy data into table.
