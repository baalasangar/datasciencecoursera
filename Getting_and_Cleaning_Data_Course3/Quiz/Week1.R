setwd("C:\\01_D_DRIVE\\MyFiles\\07_Certification\\DataScience\\Assignment\\datasciencecoursera\\Getting_and_Cleaning_Data_Course3\\Quiz")
install.packages("xlsx")
install.packages("XML")
install.packages("data.table")
library(xlsx)
library(XML)
library(data.table)

######## Quiz 1

quiz1DataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if(!file.exists("Week1_Data")){
        dir.create("Week1_Data")
}

download.file(quiz1DataURL,"./Week1_Data/quiz1.csv")

quiz1Data <- read.csv("./Week1_Data/quiz1.csv",header = TRUE,quote = "",stringsAsFactors = FALSE)
    
table(quiz1Data$VAL)
nrow(quiz1Data[(quiz1Data$VAL ==24 & !is.na(quiz1Data$VAL)),])

##########Quiz 3 
quiz2DataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
if(!file.exists("Week1_Data")){
        dir.create("Week1_Data")
}

#download.file(quiz2DataURL,"./Week1_Data/quiz2_NEW.xlsx")
dat <-  read.xlsx("./Week1_Data/QUIZ2_DATA.xlsx",header = TRUE,sheetIndex = 1,
                  colIndex = c(7:15),rowIndex = c(18:23),stringsAsFactors = FALSE)
sum(dat$Zip*dat$Ext,na.rm=T)

##########Quiz 4

quiz3DataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml" 
if(!file.exists("Week1_Data")){
        dir.create("Week1_Data")
}
download.file(quiz3DataURL,"./Week1_Data/quiz3Data.xml")

quiz3Data <- xmlTreeParse("./Week1_Data/quiz3Data.xml",useInternalNodes = TRUE)
rootNode <- xmlRoot(quiz3Data)
# getResNames <- function(restaurantsData){
#         # if(restaurantsData[[1]][[2]][[1]] == '21231'){
#         #         #data.frame(resName = c(restaurantsData[[1]][[1]][[1]]))
#         #         print(restaurantsData[[1]][[1]])
#         # }
#         # 
#         # if(!is.null(restaurantsData))
#         # print(restaurantsData)
#         print(restaurantsData$row$row$name)
# }
# xmlApply(rootNode[[1]],getResNames)

xmldf <- xmlToDataFrame(rootNode[[1]])
nrow(xmldf[(xmldf$zipcode == '21231' & !is.na(xmldf$zipcode) ),])

############# Quiz 5 
quiz5DataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

download.file(quiz5DataURL,"./Week1_Data/quiz5.csv")
DT <- fread("./Week1_Data/quiz5.csv",sep = ",",stringsAsFactors = FALSE,header = TRUE)
system.time(tapply(DT$pwgtp15,DT$SEX,mean))

system.time(DT[,mean(pwgtp15),by=SEX])

system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})

system.time(mean(DT$pwgtp15,by=DT$SEX))

system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})

system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
