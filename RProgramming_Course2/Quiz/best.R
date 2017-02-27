best <- function(state, outcome){
        
        outcomeData <- get_OutCome_CareMeasure()
        outcomeList <- c("heart attack"=11,"heart failure"=17,"pneumonia"=23) 
        selectedColnList <- c("heart attack"=3,"heart failure"=4,"pneumonia"=5) 
        uniqueStatList <- uniqueStateList(outcomeData$State)
       
        if(is.null(outcome) | is.na(outcome) | is.na(outcomeList[outcome])){
                stop("invalid outcome",call. = TRUE)
        }
        if(is.null(state) | is.na(state) | is.na(match(state,uniqueStatList))){
                stop("invalid state",call. = TRUE)
        }
        
        selectedData <- outcomeData[c(2,7,outcomeList)]
        selectedData <- selectedData[order(selectedData$State,selectedData$Hospital.Name,na.last = NA),]
        selectedData <- na.omit(selectedData)
        minData <- sapply(split(selectedData,factor(selectedData$State)),
                          function(stateObject)
                                  stateObject[(stateObject [,selectedColnList[outcome]]==min(stateObject[,selectedColnList[outcome]])),]
                         )
        minData[,c(state)]$Hospital.Name
        
}

uniqueStateList <- function(stateList){
        filteredStateList <- unique(stateList)
        filteredStateList
}


get_OutCome_CareMeasure <- function(){
        outcome <- read.csv("./Week_4_PA_data/outcome-of-care-measures.csv",na.strings = "Not Available",stringsAsFactors = FALSE)
        outcome
}