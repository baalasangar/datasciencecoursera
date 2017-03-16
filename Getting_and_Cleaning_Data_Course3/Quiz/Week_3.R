############ Quiz 1

if(!file.exists("./Week3_data")) {
        dir.create("./Week3_data")
}
quiz1FileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv";
download.file(quiz1FileURL,"./Week3_data/quiz1Data.csv")
quiz1Data <- read.csv("./Week3_data/quiz1Data.csv",stringsAsFactors = FALSE)

str(quiz1Data)

which(quiz1Data$ACR ==3 & quiz1Data$AGS == 6)

############# Quiz 2

install.packages("jpeg")
library(jpeg)
quiz2URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(quiz2URL,"./Week3_data/quiz2Img.jpg",mode = "wb")

jbgBytes <- readJPEG("./Week3_data/quiz2Img.jpg",native = TRUE)

quantile(jbgBytes,probs = c(0.3,0.8))

############## Quiz3 

countryDataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

educationDataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(countryDataURL,"./Week3_data/countryData.csv")
countryData <- read.csv("./Week3_data/countryData.csv",stringsAsFactors = FALSE,
                        skip = 3,na.strings = "")

download.file(educationDataURL,"./Week3_data/educationData.csv")
educationData <- read.csv("./Week3_data/educationData.csv",stringsAsFactors = FALSE,
                          na.strings = "")

install.packages("dplyr")
library("dplyr")

##### Cleaning Country Data ###########

countryData <- countryData %>% rename(CountryCode = X,US.dollars = US.dollars.)  %>% select(-matches("X")) 
countryData <- filter(countryData, !is.na(countryData$CountryCode))

head(countryData)
tail(countryData)

countyEduMerged <- merge(countryData,educationData,by="CountryCode",all = TRUE )

##### No of Rows Merged
nrow(countyEduMerged)-nrow(countyEduMerged[is.na(countyEduMerged$Long.Name),])


countyEduMerged$Ranking <- as.numeric(countyEduMerged$Ranking)
countyEduMerged <- arrange(countyEduMerged,desc(Ranking))

########### 13th Country
countyEduMerged[13,]$Long.Name

############# Quiz 4 


summarise(group_by(countyEduMerged,Income.Group),AvgGDPRanking = mean(Ranking,na.rm = TRUE))

########### Quiz 5
install.packages("Hmisc")
library(Hmisc)

table(countyEduMerged$Income.Group, cut2(countyEduMerged$Ranking,g=5))





