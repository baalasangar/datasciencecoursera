
############# Read and Write from MYSQL #############
install.packages("RMySQL")
library(RMySQL)

dbConObject <- dbConnect(MySQL(),user='SPEEDUser', 
          password='speed123',  host='199.63.64.63',db="SPEED")

#databasesResult <- dbGetQuery(dbConObject,"show databases;")

tableList <- dbListTables(dbConObject)

tableList

data <- dbSendQuery(dbConObject,"SELECT * FROM JobMonitor")

fetch(data,n=2)
dbClearResult(data)

summary(data$JobID)

dbDisconnect(dbConObject)

############### Read and Write from HDF5 ############3

source("http://bioconductor.org/biocLite.R")

biocLite("rhdf5")
library(rhdf5)

a<-h5createFile("example.h5")
a
h5createGroup("example.h5","test")

h5ls("example.h5")

n = c(2, 3, 5) 
s = c("aa", "bb", "cc") 
b = c(TRUE, FALSE, TRUE) 
df = data.frame(n, s, b,stringsAsFactors = FALSE)  
df2<-df 



h5write(df1,"example.h5","test/df6")
h5read("example.h5","test")

H5close()


################# Getting data from WEB #########################3

install.packages("httr")
library(httr)
URL <- "http://199.63.64.189/ITSS/TS-EnggIT/TDC_2011/branches/EDS_NEW_REPORT/EDS_New/"
hd<- handle("http://199.63.64.189/ITSS/TS-EnggIT/TDC_2011/branches/EDS_NEW_REPORT/EDS_New/",authenticate("e550774","tgbmlp_85"))

webdata <- GET(URL,authenticate("E550774","tgbmlp_85"))

library(XML)
parsedHTMl <- htmlParse(webdata,asText = TRUE)

xpathSApply(parsedHTMl,"//li",xmlValue)




