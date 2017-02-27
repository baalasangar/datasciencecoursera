rankall <- function(outcome, num = "best") {
        outcomeData <- get_OutCome_CareMeasure()
        outcomeList <- c("heart attack"=11,"heart failure"=17,"pneumonia"=23) 
        selectedColnList <- c("heart attack"=3,"heart failure"=4,"pneumonia"=5) 
        uniqueStateList <- uniqueStateList(outcomeData$State)
        
        if(is.null(outcome) | is.na(outcome) | is.na(outcomeList[outcome])){
                stop("invalid outcome",call. = TRUE)
        }
        
        selectedData <- outcomeData[c(2,7,outcomeList[outcome])]
        resultDF <- data.frame(row.names = c("State","hospital"))
        minRateForState <- function(state,number){
                
                minData <- selectedData[(selectedData$State == state & !is.na(selectedData[,3]) ),] 
                minData <- minData[order(minData[,3],minData$Hospital.Name),]
                indexToPull <- if(is.numeric(number)){
                        number
                }else{
                        if(number =="best"){
                                1
                        }else{
                                nrow(minData)
                        }
                }
                minData <- minData[indexToPull,]
                resultDF <<- rbind.data.frame(resultDF,data.frame(state,hospital=minData[,1]))
        }
        mapply(minRateForState,uniqueStateList,num,SIMPLIFY = FALSE)
        # for(state in uniqueStateList){
        #         minData <- selectedData[(selectedData$State == state & !is.na(selectedData[,3]) ),] 
        #         minData <- minData[order(minData[,3],minData$Hospital.Name),]
        #         minData <- minData[num,]
        #        resultDF <- rbind.data.frame(resultDF,data.frame(state,hospital=minData[,1]))
        # }
        # resultDF <- resultDF[order(resultDF$state),]
        resultDF <- resultDF[order(as.character(resultDF$state)),]
        
        
        
}


uniqueStateList <- function(stateList){
        filteredStateList <- unique(stateList)
        filteredStateList
}


get_OutCome_CareMeasure <- function(){
        outcome <- read.csv("./Week_4_PA_data/outcome-of-care-measures.csv",na.strings = "Not Available",stringsAsFactors = FALSE)
        outcome
}
        
        