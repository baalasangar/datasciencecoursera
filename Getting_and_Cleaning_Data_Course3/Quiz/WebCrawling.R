install.packages("httr")
install.packages("XML")

library(httr)
library(XML)

path <- "C:/data/telegram/"
url <- "http://www.telegraph.co.uk"
yearList <- 2000
monthList <- 2
dayList <- 1:31

setwd(path)
df<-data.frame(Year=character(),Month=character(),Day=character())

for(year in yearList){
        for(month in monthList){
                for(day in dayList){
                        df<-rbind(df,data.frame(Year=year,Month=month,Day=day))   
                }
        }
}

newsPathList<- mapply(function(year,month,day){
        newsListContent <- content(GET(paste0(url,"/archive/",year,"-",month,"-",day,".html")),as="text")
        xpathSApply(htmlParse(newsListContent,asText = TRUE,ignoreBlanks = TRUE),
                                "//div[@class='summary']/h3/a",xmlAttrs)
},df$Year,df$Month,df$Day)

mapply(function(newsPathName,index){
    if(length(newsPathName) >=1){
        folderName <- paste0(df[index,]$Year,"-",df[index,]$Month,"-",df[index,]$Day)   
        if(!file.exists(folderName)){
                dir.create(folderName)
        }
        for(newsPath in newsPathName){
                newshtmlContent <- content(GET(paste0(url,newsPath)),as="text")
                newsData <- xpathSApply(htmlParse(newshtmlContent,asText = TRUE,
                                                  ignoreBlanks = TRUE),
                            "//div[@class='story']",xmlValue)
                newsPathArray <- strsplit(newsPath,"/")
                write(newsData,file = gsub(".html","",paste0(folderName,"/",
                                             newsPathArray[[1]][length(newsPathArray[[1]])],".text")))
        }
   }
},newsPathList,1:length(newsPathList))
















