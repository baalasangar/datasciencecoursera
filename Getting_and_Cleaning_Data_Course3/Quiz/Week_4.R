setwd("C:\\01_D_DRIVE\\MyFiles\\07_Certification\\DataScience\\Assignment\\datasciencecoursera\\Getting_and_Cleaning_Data_Course3\\Quiz")

if(!file.exists("Week4_Data")){
        dir.create("Week4_Data")
}
#############Quiz 1 ############

quiz1DataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(quiz1DataURL,"./Week4_Data/quiz1.csv")
quiz1Data <- read.csv("./Week4_Data/quiz1.csv",header = TRUE,quote = "",stringsAsFactors = FALSE)

head(quiz1Data)
names(quiz1Data)

strsplit(names(quiz1Data),"wgtp")[[123]]

###########Quiz 2#############33
quiz2DataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(quiz2DataURL,"./Week4_Data/quiz2.csv")
quiz2Data <- read.csv("./Week4_Data/quiz2.csv",header = TRUE,
                      stringsAsFactors = FALSE,skip = 3,nrows = 215,na.strings = "")

quiz2Data$US.dollars. <- gsub(",","",quiz2Data$US.dollars.)


mean(as.numeric(quiz2Data[(quiz2Data$US.dollars. != ".."),c("US.dollars.")]),na.rm = TRUE)

########### Quiz 3 #########3

quiz3Data <- read.csv("./Week4_Data/quiz2.csv",header = TRUE,
                      stringsAsFactors = FALSE,skip = 3,nrows = 215,na.strings = "")

library(dplyr)
head(quiz3Data)
quiz3Data %>% rename(countryNames=Economy,countryCode = X) 
grep("^United",quiz3Data$countryNames)

##########################Quiz 4 

###### GDP data ###########
countryData <- read.csv("./Week4_Data/quiz2.csv",header = TRUE,
                      stringsAsFactors = FALSE,skip = 3,nrows = 215,na.strings = "")
educationDataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(educationDataURL,"./Week4_Data/educationData.csv")
educationData <- read.csv("./Week3_data/educationData.csv",stringsAsFactors = FALSE,
                          na.strings = "")

countryData <- countryData %>% rename(CountryCode = X,US.dollars = US.dollars.) %>% filter(!is.na(CountryCode)) %>% select(-matches("X")) 

countyEduMerged <- merge(countryData,educationData,by="CountryCode",all = TRUE )

grep("fin*",countyEduMerged$Special.Notes)

###### Approach 1
countyEduMerged[grep("*fis(.*)june*",tolower(countyEduMerged$Special.Notes)),]$Special.Notes 

######Approach 2
isFiscalYear <-grepl("fiscal year end",tolower(countyEduMerged$Special.Notes))
isJune <- grepl("june",tolower(countyEduMerged$Special.Notes))
table(isFiscalYear,isJune)

### grep() vs grepl :One returns indices vector and the other returns a logical vector.


######### Quiz 5 ############
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)



install.packages("lubridate")
library(lubridate)

#######Approach 1
length(sampleTimes[year(sampleTimes) == 2012])
length(sampleTimes[year(sampleTimes) == 2012 & weekdays(sampleTimes)=="Monday"])

########## Approach 2
addmargins(table(year(sampleTimes),weekdays(sampleTimes)))

