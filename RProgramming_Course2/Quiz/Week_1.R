########## Quiz 8

x <- list(2, "a", "b", TRUE)

class(x[[2]])

##### Quiz 9 
x <- 1:4
y <- 2:3
print(x+y)

#####Quiz 10

x <- c(3, 5, 1, 10, 12, 6)
x[x %in% 1:5] <- 0
x[x < 6] <- 0 <- 0
x[x <= 5] <- 0 
x
############### Load data for Quiz 11 to 20

setwd("C:\\01_D_DRIVE\\MyFiles\\07_Certification\\DataScience\\Assignment\\datasciencecoursera\\RProgramming_Course2\\Quiz");
getwd()

data<-read.csv(file = "./Week1_data/hw1_data.csv",header = TRUE)

############Quiz 11
colnames(data) 

#########Quiz 12
data[1:2,] 
head(data,2)

######### Quiz 13
nrow(data)

####### Quiz 14
tail(data,2)

########### Quiz 15

data[47,]
data[47,c("Ozone")]

############ Quiz 16

 ozenData_NA <- data[,c("Ozone")]
 length(ozenData_NA[is.na(ozenData_NA)])
 
 ########## Quiz 17
 ozenData <- data[,c("Ozone")]
 mean(ozenData[!is.na(ozenData)])
 
 ######### Quiz 18
 q18Data <- data[(data$Ozone > 31 & !is.na(data$Ozone) & data$Temp >90 & !is.na(data$Temp)),]
 mean(q18Data$Solar.R[!is.na(q18Data$Solar.R)])
 
 q18Data
 
 ######### Quiz 19
newData <- data[(data$Month ==6) & !is.na(data$Month),]
mean(newData$Temp[!is.na(newData$Temp)])

########Quiz 20

q20Data<- data[(data$Month ==5) & !is.na(data$Month),]
max(q20Data$Ozone[!is.na(q20Data$Ozone)])






 
 
 
