library(datasets)
library(help = "datasets")

########## Quiz 1 
data("iris")

head(iris)

####Way 1
mean(iris[(iris$Species == 'virginica'),c('Sepal.Width')])

##### Way 2
apply(as.matrix(iris[(iris$Species == 'virginica'),c('Sepal.Width')]),
      2,mean)


## Way 3
dataSplit <-split(iris[,1:4],iris$Species)
lapply(dataSplit,function(x)colMeans(x[,1:4]))



########## Quiz 2

apply(iris[,1:4],2,mean)
colMeans(iris[,1:4])

########## Quiz 3

data("mtcars")
debug(ls)
.Ob <- 1
ls(pattern = "O")


?ls


ls
head(mtcars)





sapply(split(mtcars$mpg,mtcars$cyl),mean)
tapply(mtcars$mpg,mtcars$cyl,mean)
with(mtcars,tapply(mpg,cyl,mean))

test


#############Quit 4

carHpAvgMatrix <- as.matrix(with(mtcars,tapply(hp,cyl,mean)))

round(carHpAvgMatrix[3,1] - carHpAvgMatrix[1,1])






