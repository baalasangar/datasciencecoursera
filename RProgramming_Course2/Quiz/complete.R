complete <- function(directory,id=1:332){
        pData <- readPollutionData(directory,id)
        pDataCompleteData <- pData[(!is.na(pData$sulfate) & !is.na(pData$nitrate)),]
        pDataCompDataSummary <- data.frame(row.names = c("id","nobs"))
        for( idIndex in id){
                count <- nrow(pDataCompleteData[(pDataCompleteData$ID == idIndex),])
                pDataCompDataSummary <- rbind(pDataCompDataSummary,data.frame(idIndex,count))
        }
        pDataCompDataSummary

}