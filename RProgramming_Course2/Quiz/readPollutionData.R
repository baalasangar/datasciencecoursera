baseDir <- "./Week_2_PA_data"

readPollutionData <- function(directory,id=1:332){
        path <- paste(baseDir,directory,sep = "/")
        fileList <- list.files(path)
        dataDF <- data.frame(row.names = c("Date","sulfate","nitrate","ID"))
        for(fileIndex in id){
                fileName <- fileList[fileIndex]
                fullPath <- paste(path,fileName,sep = "/")
                dataDF <- rbind(dataDF,read.csv(file = fullPath,stringsAsFactors = FALSE))
                #data <- read.csv(file = fullPath,stringsAsFactors = FALSE)
        }
        dataDF
        
}

readCompletePollutionData <- function(directory,id=1:332){
        data <- readPollutionData(directory,id)
        data <- data[(!is.na(data$sulfate) & !is.na(data$nitrate)),c("sulfate","nitrate")]
        data
}