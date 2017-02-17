corr <- function(directory,threshold=0){
         complateDataIndex <- complete(directory)
         fileIndexVector <- complateDataIndex[(complateDataIndex$count > threshold),c("idIndex")]
         corDataFrame <- data.frame(row.names = c("CorValue"))
         for(fileIndex in fileIndexVector){
                 index <- 1
                 dataDF <- readCompletePollutionData(directory,fileIndex)
                 # corDataFrame$CorValue[index] <- c(cor(dataDF$nitrate,dataDF$sulfate))
                 # index <- index +1                                  
                 corDataFrame<-rbind(corDataFrame,
                                     data.frame("CorValue"=c(cor(dataDF$nitrate,dataDF$sulfate))))
                                     
         }
         dataFrameVector <- as.vector(as.matrix(corDataFrame))
         dataFrameVector
}

