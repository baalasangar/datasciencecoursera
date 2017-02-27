rankall <- function(outcome, num = "best") {
        outcomeData <- get_OutCome_CareMeasure()
        outcomeList <- c("heart attack"=11,"heart failure"=17,"pneumonia"=23) 
        uniqueStatList <- uniqueStateList(outcomeData$State)
}


uniqueStateList <- function(stateList){
        filteredStateList <- unique(stateList)
        filteredStateList
}


get_OutCome_CareMeasure <- function(){
        outcome <- read.csv("./Week_4_PA_data/outcome-of-care-measures.csv",na.strings = "Not Available",stringsAsFactors = FALSE)
        outcome
}
        
        