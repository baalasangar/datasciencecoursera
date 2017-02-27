########### Quiz 1
set.seed(1)
rpois(5, 2)


######### Quiz 5
set.seed(10)
x <- rep(0:1, each = 5)
e <- rnorm(10, 0, 20)
y <- 0.5 + 2 * x + e


x <- c(1,2)
x2<-c(3,2)
y<-c(3,4)
summaryRprof(

fit <- lm(y ~ x + x2)
)