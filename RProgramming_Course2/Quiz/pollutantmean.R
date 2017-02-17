


pollutantmean <- function(directory,pollutant,id = 1:332){
        pData <- readPollutionData(directory,id)
        specPData <- pData[,c(pollutant)]
        mean(specPData[!is.na(specPData)])
        
}        

