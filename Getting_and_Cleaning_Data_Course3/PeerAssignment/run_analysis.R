package <- c("dplyr","reshape2","data.table","memisc")
sapply(package,require,character.only = TRUE, quietly = TRUE)




### Set the Working directory
setwd("C:\\01_D_DRIVE\\MyFiles\\07_Certification\\DataScience\\Assignment\\datasciencecoursera\\Getting_and_Cleaning_Data_Course3\\PeerAssignment")

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

####  1 : Merges the training and the test sets to create one data set.

subject_test_df <-readData("./data/UCI HAR Dataset/test/","subject_test.txt")
X_test_df <-readData("./data/UCI HAR Dataset/test/","X_test.txt")
y_test_df <-readData("./data/UCI HAR Dataset/test/","y_test.txt")

subject_train_df <-readData("./data/UCI HAR Dataset/train/","subject_train.txt")
X_train_df <-readData("./data/UCI HAR Dataset/train/","X_train.txt")
y_train_df <-readData("./data/UCI HAR Dataset/train/","y_train.txt")

subject_test_train_df <- rbind(subject_test_df,subject_train_df)
X_test_train_df <- rbind(X_test_df,X_train_df)
y_test_train_df <- rbind(y_test_df,y_train_df)




subject_test_train_df <- dplyr::rename(subject_test_train_df,subject=V1)
y_test_train_df <- dplyr::rename(y_test_train_df,activity=V1)

df <- cbind(subject_test_train_df,y_test_train_df,X_test_train_df)

######  2 :Extracts only the measurements on the mean and standard deviation for each measurement.




featuresData <-readData("./data/UCI HAR Dataset/","features.txt")
featuresData<-dplyr::rename(featuresData,featureCode=V1,featureName=V2)
featuresData <- featuresData[grep("mean\\(\\)|std\\(\\)",featuresData$featureName),]



############### 3:Uses descriptive activity names to name the activities in the data set


activityLabelData <-readData("./data/UCI HAR Dataset/","activity_labels.txt")
activityLabelData<-dplyr::rename(activityLabelData,activity=V1,activityName=V2)

############### 4:Appropriately labels the data set with descriptive variable names.

df <- merge(df,activityLabelData,all.x = TRUE,by = "activity")

#### Filter out the feature Columns

filteredCol <- c("activity","subject","activityName",paste0("V",featuresData$featureCode))
df<-df[,filteredCol]

######## Transforming columns to rows (reshaping the data frame)

df <- melt(df,id=c("activity","subject","activityName"))



###### Add more description to feature

featuresData$axis <- mapply(function(featureName){
        axis <- NA
        if(grepl("Z$",featureName)){
                axis <- "Z"    
        }else if(grepl("Y$",featureName)){
                axis <- "Y"
        }else if(grepl("X$",featureName)){
                axis <- "X"
        }
        axis
},featuresData$featureName)

featuresData$time_or_freq <- mapply(function(featureName){
        
        if(grepl("^t",featureName)){
                "Time"    
        }else if(grepl("^f",featureName)){
                "Frequency"
        }else {
                NA
        }
},featuresData$featureName)

featuresData$instrument <- mapply(function(featureName){
        
        if(grepl("^(.*)Acc(.*)$",featureName)){
                "Acclerometer"    
        }else if(grepl("^(.*)Gyro(.*)$",featureName)){
                "Gryroscope"
        }else {
                NA
        }
},featuresData$featureName)

featuresData$accleration <- mapply(function(featureName){
        
        if(grepl("^(.*)BodyAcc(.*)$",featureName)){
                "Body"    
        }else if(grepl("^(.*)GravityAcc(.*)$",featureName)){
                "Gravity"
        }else {
                NA
        }
},featuresData$featureName)

featuresData$mean_or_std <- mapply(function(featureName){
        
        if(grepl("^(.*)mean\\(\\)(.*)$",featureName)){
                "Mean"    
        }else if(grepl("^(.*)std\\(\\)(.*)$",featureName)){
                "std"
        }else {
                NA
        }
},featuresData$featureName)

featuresData$jerk_measure <- mapply(function(featureName){
        
        if(grepl("^(.*)jerk(.*)$",tolower(featureName))){
                "Y"    
        }else {
                "N"
        }
},featuresData$featureName)

featuresData$Magnitude_measure <- mapply(function(featureName){
        
        if(grepl("^(.*)mag(.*)$",tolower(featureName))){
                "Y"    
        }else {
                "N"
        }
},featuresData$featureName)

###### Merge the feature to data frame

featuresData$featureid <- paste0("V",featuresData$featureCode)
df<-dplyr::rename(df,featureid=variable,featureValue=value)
df <- merge(df,featuresData,all = TRUE,by="featureid")



######### 5:From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# dfTidy <- select(df,-grep("featureid|activity|featureCode|featureName",colnames(df)))
# grep("[featureid|activity|featureCode|featureName]",colnames(df))



dfTidy <- as.data.table(df[,c("subject","activityName","axis","time_or_freq",
        "instrument","accleration","mean_or_std","jerk_measure","Magnitude_measure","featureValue")])


dfTidy <- dfTidy[,list(Average=mean(featureValue)),by=c("subject","activityName","time_or_freq",
                "accleration","instrument","jerk_measure","Magnitude_measure","mean_or_std","axis")]

########## Write the data to file
write.table(dfTidy,"tidyData.txt", row.name=FALSE)



dfCodeBookData <- data.set(
        
        subject = dfTidy$subject,  
        activityName = dfTidy$activityName,
        time_or_freq = dfTidy$time_or_freq,
        accleration = dfTidy$accleration,
        instrument = dfTidy$instrument,
        jerk_measure  = dfTidy$jerk_measure,
        Magnitude_measure = dfTidy$Magnitude_measure,
        mean_or_std = dfTidy$mean_or_std,
        axis = dfTidy$axis,
        Average =dfTidy$Average
        
        )

dfCodeBookData<- within(dfCodeBookData,{
        description(subject)<- "ID of the person who involved in experiment.value range from 1-30"
        description(activityName) <- "Activity done by the person during experiment"
        description(time_or_freq) <- "Feature : Time signal or Frequency Signal"
        description(accleration) <- "Feature: Acceleration signal (Body or Gravity)"
        description(instrument) <- "Feature: Measuring instrument (Accelerometer or Gyroscope)"
        description(jerk_measure) <- "	Feature: Jerk signal .Has the value Y or N"
        description(Magnitude_measure) <- "Feature: Magnitude of the signals .Has the value Y or N"
        description(mean_or_std) <- "Feature: Mean or SD"
        description(axis) <- "Feature: 3 axis (X,Y,Z)"
        description(Average) <- "Average of subject and feature"
})

Write(codebook(dfCodeBookData),file="codebook.md")






