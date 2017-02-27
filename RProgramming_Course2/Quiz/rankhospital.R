rankhospital <- function(state, outcome, num = "best") {
        outcomeData <- get_OutCome_CareMeasure()
        outcomeList <- c("heart attack"=11,"heart failure"=17,"pneumonia"=23) 
        uniqueStatList <- uniqueStateList(outcomeData$State)
        if(is.null(outcome) | is.na(outcome) | is.na(outcomeList[outcome])){
                stop("invalid outcome",call. = TRUE)
        }
        if(is.null(state) | is.na(state) | is.na(match(state,uniqueStatList))){
                stop("invalid state",call. = TRUE)
        }
        stateData <- outcomeData[(outcomeData$State == state),]
        stateData <- stateData[order(stateData[,outcomeList[outcome]],stateData[,2]),]
        stateData <- stateData[,c(2,7,outcomeList)]
        stateData<-na.omit(stateData)
        stateData$Hospital.Name[num]
        if(is.numeric(num)  ){
                if(nrow(outcomeData[(outcomeData$State ==state),]) >=num){
                        stateData$Hospital.Name[num]
                }else{
                         NA  
                }
                        
                        
                
                
        }else{
                if(num =="best"){
                        stateData$Hospital.Name[1]
                }else{
                        tail(stateData$Hospital.Name,1)
                }
        }

}       


uniqueStateList <- function(stateList){
        filteredStateList <- unique(stateList)
        filteredStateList
}


get_OutCome_CareMeasure <- function(){
        outcome <- read.csv("./Week_4_PA_data/outcome-of-care-measures.csv",na.strings = "Not Available",stringsAsFactors = FALSE)
        outcome
}