---
title: "README"
author: "Sherif EL-Farahaty"
date: "October 25, 2015"
output: html_document
---

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

The script is divided into XXXX sections. Following are description of each section

## Preparation
1- Data downloading: where we download the zip file from the provided url, store it in the local storage, and unzip it.

2- Read the master data which contains the activity names, subject id , features , ...etc

3- Read the test data into several variables, one for each file.

4- Read the training data into several variables, one for each file.

## Merging test and training data set. "Answer to question # 1"


1- Merging all test & training data into one variable (har_dataset)

## Mean & STD measurements extraction. "Answer to question # 2"

1- Extracting all feature names that has word mean or std using grep function, and storing its index into ft_idx_mean_std variable. This variable consists of 79 feature index.

2- Converting the class of ft_idx_mean_std varaible from data.frame into integer vector.

3- Extracting  the relevant features measurements, based on the feature index from the above steps, from the merged x table which consists all measurements of 561 features.

2- adding into new file the sub_id and act_id.

## Uses descriptive activity names to name the activities in the data set. "Answer to question # 3"

1- Converting the act_id into activity name based on the provided activity labels to be more informative.

## Appropriately labels the data set with descriptive variable name. "Answer to question # 4"

1 - Converting the measurement names from V names to the feature names as was collected previously in step 3 to be more informative.

## Create another tidy data set based on average for each activity and each subject.

2- applying mean functionality after grouping the dataset by activity and subject.

## Writing the new dataset into local file.

1- using write.table to write the generated data set from the previous step into the local file.









