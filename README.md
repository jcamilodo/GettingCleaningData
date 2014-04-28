## Getting and Cleaning Data Project
* Unzip the source 
  ( https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

* Create directory "C:\R\gcdata"

* Put getdata-projectfiles-UCI HAR Dataset.zip, and unzip.  (show "UCI HAR Dataset" folder
  
* Put run_analysis.R to "C:\R\gcdata"

* in RStudio: setwd(""C:/R/gcdata"")

  and then: source("run_analysis.R")

* The latter will run the R script, it will read the dataset and write these files:

  merged_data.txt  -- 8.35 Mb, a 10299x68 data frame

  data_averages.txt  -- 220 kb, a 180x68 data frame

  The script normally runs for ~30 seconds, but the exact number depends on your system.

* Use data <- read.table("data_averages.txt") to read the latter.
  It is 180x68 because there are 30 subjects and 6 activities,
  thus "for each activity and each subject" means 30*6=180 rows.

  