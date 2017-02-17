############## Quiz 1

cube <- function(x,n){
        x^3
}
cube(3)


####### Quiz 2

x<-1:10
if(x>5){
        
        x<-0
}


############## Quiz 3

f <- function(x){
        g <- function(y){
                y+z
        }
        z <- 4
        x + g(x)
}

z <- 10
f(3)

########## Experiement on Quiz 3 

f <- function(x){
        
        z <- 4
        x + g(x)
}

g <- function(y){
                y+z
        }

z <- 10
f(3)


####### Quiz 4

x<-5
y<-if(x<3){
        NA
        
}else{
        10
}
print(y)



