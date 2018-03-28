library(ggplot2)

dataCreate <- function(mean1=5.84, mean2=3.05, n1=150, n2=150, sd1=.8253, sd2=.4344){
  mydf <- data.frame(sepalLen=rnorm(mean=mean1, n=n1, sd=sd1), sepalWid= rnorm(mean=mean2, n=n2, sd=sd2))
  return(mydf)
}
myDF1 <- dataCreate()

head(myDF1)
# melt(myDF) places it in a format that can be used to perform an anova

myReg <- function(data=myDF1){
  lreg<- lm(sepalLen~sepalWid, data=data)
  return(lreg)
 
}
lregr1 <- myReg()
summary(lregr1)

myGraph <- function(data=lregr1){
  regPlot <- ggplot( data=data, mapping=aes(x=sepalWid, y=sepalLen))+
    geom_point()+
    stat_smooth(method=lm)
  
  return(regPlot)
}
plot1 <-myGraph()
plot1
results1 <-print(summary(lregr1)$coefficients)
pvalue <-print(summary(lregr1)$coefficients[2,4])

#increasing N
myDF2 <- dataCreate(n1=500, n2=500)
lregr2 <- myReg(data=myDF2)
plot2 <-myGraph(data=lregr2)
plot2
results2 <- print(summary(lregr2)$coefficients) 



results1[2,4]
results2[2,4]

# decreasing sd
myDF3 <- dataCreate(sd1=.1, sd2=.1)
lregr3 <- myReg(data=myDF3)
plot3 <-myGraph(data=lregr3)
plot3
rel3<- print(summary(lregr3)$coefficients)
#increasing sd
myDF2 <- dataCreate(sd1=3)
lregr2 <- myReg(data=myDF2)
#plot2 <-myGraph(data=lregr2)
#plot2
sd2inc<- print(summary(lregr2)$coefficients)

# new simulated data model
n <- 50
il33 <- 22.2 + runif(n, min=-2.2,max=2.2)
il13 <- 1.369*il33 + runif(n,min=-1.6, max=1.6) 
ID <- seq_len(n)
regData <- data.frame(ID,il33,il13)
#linear model
regModel <- lm(il13~il33, data=regData)
summary(regModel)$coefficients
z <- summary(regModel)
z$coefficients
mySlope <- z$coefficients[2,1]
pvalue<-summary(regModel)$coefficients[2,4]
# this will most definitely give us a significant p value. Now to put it into a model
# now to put this into a function

dataCreate <- function(mean1=22.2, n1=50, n2=50){
  mydf <- data.frame(il33= mean1+ runif(n, min=-2.2,max=2.2), il13= 1.369*mean1+ runif(n,min=-1.6, max=1.6))
  return(mydf)
}
myDF1 <- dataCreate()

myReg <- function(data=myDF1){
  lreg<- lm(il13~il33, data=data)
  return(lreg)
}
lregr1 <- myReg()
summary(lregr1)

myGraph <- function(data=lregr1){
  regPlot <- ggplot( data=data, mapping=aes(x=il33, y=il13))+
    geom_point()+
    stat_smooth(method=lm)
  
  return(regPlot)
}
plot1 <-myGraph()
plot1
pvalue <-print(summary(lregr1)$coefficients[2,4])
summary(regModel)$coefficients
z <- summary(regModel)
z$coefficients
mySlope <- z$coefficients[2,1]

#make il33 rnorm, il13 part of it.