######### Quiz 1 

install.packages("jsonlite")

library(jsonlite)
library(httr)

data <- GET("https://api.github.com/users/jtleek/repos")
jsonData <- content(data)
df <- jsonlite::fromJSON(toJSON(jsonData))
dataSharinProjectData <- df[(df$name =='datasharing'),]
head(dataSharinProjectData$created_at)

?content

####################Quiz 2 ##########

quiz2DataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

if(!file.exists("Week2_Data")){
        dir.create("Week2_Data")
}

download.file(quiz2DataURL,"./Week2_Data/quiz2.csv")

acs <- read.csv("./Week2_Data/quiz2.csv",header = TRUE,quote = "",stringsAsFactors = FALSE)

install.packages("sqldf")
library(sqldf)

summary(acs$pwgtp1)
sqldf("select pwgtp1 from acs where AGEP < 50")

########## Quiz 3 ###########

unique(acs$AGEP)

sqldf("select distinct AGEP from acs")

############# Quiz 4 
library(httr)

htmlContentObject <- GET("http://biostat.jhsph.edu/~jleek/contact.html")
htmlContent <- content(htmlContentObject,as="text")

htmlContVector <- strsplit(htmlContent,"\n")

nchar(htmlContVector[[1]][10])
nchar(htmlContVector[[1]][20])
nchar(htmlContVector[[1]][30])
nchar(htmlContVector[[1]][100])

############Quiz 5

quiz5DataURl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

quiz5DF <- read.fwf(file = url(quiz5DataURl),skip = 4,widths = c(-1,9,-5,4,4,-5,4,4,-5,4,-1,3,-5,4,-1,3))
head(quiz5DF,n=1)
sum(quiz5DF[,4])


