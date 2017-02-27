source("best.R")
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")

source("rankhospital.R")

rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)


source("rankall.R")
minData <- rankall("heart attack", 20)
head(rankall("heart attack", 20), 10)

tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)



source("best.R")
best("SC", "heart attack") ############# Quiz 1 
best("NY", "pneumonia") ########### Quiz 2
best("AK", "pneumonia") ########### Quiz 3

source("rankhospital.R")
rankhospital("NC", "heart attack", "worst") ####### Quiz 4
rankhospital("WA", "heart attack", 7) ###### Quiz 5
rankhospital("TX", "pneumonia", 10) ###### Quiz 6 ---- To Work
rankhospital("NY", "heart attack", 7) ###### Quiz 7

source("rankall.R") 

############# Quiz 8 

r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)

############# Quiz 9

r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)

############ Quiz 10 

r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)