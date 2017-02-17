
####### To Unzip the data file 
unzip("rprog_data_specdata.zip",exdir = "Week_2_PA_data")


source("readPollutionData.R")
source("pollutantmean.R")
source("complete.R")
source("corr.R")

print(pollutantmean("specdata", "sulfate", 1:10))
print(pollutantmean("specdata", "nitrate", 70:72))
print(pollutantmean("specdata", "nitrate", 23))
print(pollutantmean("specdata", "sulfate", 34))
print(pollutantmean("specdata", "nitrate"))




print(complete("specdata", 1))
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)


corr("specdata", 150)

cr <- corr("specdata", 150)
sort(cr)
head(cr)

summary(cr)


cr <- corr("specdata", 400)
head(cr)

summary(cr)

cr <- corr("specdata", 5000)
summary(cr)

length(cr)

cr <- corr("specdata")
summary(cr)

length(cr)
sort(cr)
class(as.vector(cr))

as.vector(rbind(c(1),c(2)))
as.vector(data.frame("test"=c(1,2,3)))
as.vector(as.matrix(data.frame("test"=c(1,2,3))))




############## Quiz 1 

pollutantmean("specdata", "sulfate", 1:10)

####### Quiz 2

pollutantmean("specdata", "nitrate", 70:72)

####### Quiz 3 

pollutantmean("specdata", "sulfate", 34)

######## Quiz  4 

pollutantmean("specdata", "nitrate")


######### Quiz 5
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$count)

######### Quiz 6
cc <- complete("specdata", 54)
print(cc$count)

########### Quiz 7

set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "count"])


########## Quiz 8 

cr <- corr("specdata")                
cr <- sort(cr)                
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

######## Quiz 9

cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)                
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

############ Quiz 10

cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))



