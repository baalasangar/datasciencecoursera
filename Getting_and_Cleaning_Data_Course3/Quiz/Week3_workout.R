restData <- read.csv("./Week3_data/Restaurants.csv")

summary(restData)

restData$zipCodeGroup <- cut(restData$zipCode,breaks = quantile(restData$zipCode))

table(restData$zipCodeGroup,restData$zipCode)

