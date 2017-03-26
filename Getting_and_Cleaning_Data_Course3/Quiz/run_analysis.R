install.packages("dplyr")



### Set the Working directory
setwd("C:\\01_D_DRIVE\\MyFiles\\07_Certification\\DataScience\\Assignment\\datasciencecoursera\\Getting_and_Cleaning_Data_Course3\\Quiz")

## Method Check is the data folder Available 
## if not create the folder and download the file and unzipit
downloadAndUnzipData <- function(){
        if(!file.exists("data")){
                dir.create("data")
        }
        url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(url,"./data/assignmentData.zip")
        unzip("./data/assignmentData.zip",exdir = "./data")
}

readData <- function(path,fileName){
        read.table(paste0(path,fileName))
}


########### Download the data 

downloadAndUnzipData()

subject_test_df <-readData("./data/UCI HAR Dataset/test/","subject_test.txt")
X_test_df <-readData("./data/UCI HAR Dataset/test/","X_test.txt")
y_test_df <-readData("./data/UCI HAR Dataset/test/","y_test.txt")

subject_train_df <-readData("./data/UCI HAR Dataset/train/","subject_train.txt")
X_train_df <-readData("./data/UCI HAR Dataset/train/","X_train.txt")
y_train_df <-readData("./data/UCI HAR Dataset/train/","y_train.txt")

subject_test_train_df <- rbind(subject_test_df,subject_train_df)
X_test_train_df <- rbind(X_test_df,X_train_df)
y_test_train_df <- rbind(y_test_df,y_train_df)







