best <- function(state, outcome){
        
        outcomeData <- get_OutCome_CareMeasure()
        outcomeList <- c("heart attack"=11,"heart failure"=17,"pneumonia"=23) 
        uniqueStatList <- uniqueStateList(outcomeData$State)
        print(length(uniqueStatList))
        if(is.null(outcome) | is.na(outcome) | is.na(outcomeList[outcome])){
                stop("invalid outcome",call. = TRUE)
        }
        if(is.null(state) | is.na(state) | is.na(match(state,uniqueStatList))){
                stop("invalid state",call. = TRUE)
        }
        stateData <- outcomeData[(outcomeData$State == state),]
        minValue <- min(stateData[outcomeList[outcome]],na.rm = TRUE)
        print(as.integer(minValue))
        bestHospital <- stateData[(stateData[outcomeList[outcome]] == minValue & 
                                           !is.na(stateData[outcomeList[outcome]])),c(2,7,outcomeList)]
        bestHospital <- na.omit(bestHospital)
        bestHospital <- bestHospital[order(bestHospital$Hospital.Name,na.last = NA),]
        #newbestHospital <- bestHospital[order(bestHospital$State),]
        bestHospital["Hospital.Name"]
        
}

uniqueStateList <- function(stateList){
        filteredStateList <- unique(stateList)
        filteredStateList
}


get_OutCome_CareMeasure <- function(){
        outcome <- read.csv("./Week_4_PA_data/outcome-of-care-measures.csv",na.strings = "Not Available",stringsAsFactors = FALSE)
        outcome
}