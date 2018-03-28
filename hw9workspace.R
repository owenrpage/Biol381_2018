## Preliminaries
# All functions must be declared first before they are used
library(ggplot2)

###################
# Function:dataCreateNorm
# creation of values for specific variables using a normal distribution with mean and standard deviation
# input: means and, n values, and sd
# output: the generated cq values
#--------------------------
dataCreateNorm <- function(mean1=5.84, mean2=3.05, n1=150, n2=150, sd1=.8253, sd2=.4344){
  mydf <- data.frame(sepalLen=rnorm(mean=mean1, n=n1, sd=sd1), sepalWid= rnorm(mean=mean2, n=n2, sd=sd2))
  return(mydf)
}
## create a temporary variable to store the function
myDF1 <- dataCreateNorm()

####################

#####################
# Function:dataCreateGamma
# creation of values for specific variables using a gamma distribution with shape and rate
# input: n values, shape, and rate
# output: the generated  values
#--------------------------
dataCreateGamma <- function( n1=150, n2=150, rate1=8.52, rate2=16.1, shape1=49.8, shape2=49.2){
  mydf <- data.frame(sepalLen=rgamma( n=n1, rate=rate1, shape=shape1), sepalWid= rgamma(n=n2, rate=rate2, shape=shape2))
  return(mydf)
}
## create a temporary variable to store the function
myDF2 <- dataCreateGamma()
##########################

###################
# Function:myReg
# formation of linear regression based off of values created in data create
# input: data points from dataCreate
# output: p values for slope and for the independent variable
#--------------------------
myReg <- function(data=myDF1){
  lreg<- lm(sepalLen~sepalWid, data=data)
  return(lreg)
  
}
## create a temporary variable to store the function
lregr1 <- myReg()
lregr2 <- myReg(data=myDF2)
#lregr3 <- myReg(myDF3)
####################

###################
# Function:dataSummary
# a summary table of results from the linear regression
# input: linear regression
# output: table of results
dataSummary <- function(data=lregr1){
  results <-print(summary(lregr1)$coefficients)
  return(results)
}
dataResults1<- dataSummary()
dataResults2<- dataSummary(data=lregr2)
###################
# Function:myGraph
# a ggplot2 graph of the linear regression model from myReg 
# input: data, il 13 and il33 cq values
# output: visualized graph
#--------------------------
myGraph <- function(data=lregr1){
  regPlot <- ggplot( data=data, mapping=aes(x=sepalWid, y=sepalLen))+
    geom_point()+
    stat_smooth(method=lm)
  
  return(regPlot)
}
plot1 <-myGraph()
plot2 <-myGraph(data=lregr2)
####################


# Body of code
#myDF1
#myDF2
#lregr1
#lregr2
dataResults1
dataResults2
plot1
plot2



dataCreate <- function(mean1=5.84, mean2=3.05, n1=150, n2=150, sd1=.8253, sd2=.4344){
  mydf <- data.frame(sepalLen=rnorm(mean=mean1, n=n1, sd=sd1), sepalWid= rnorm(mean=mean2, n=n2, sd=sd2))
  return(mydf)
}
myDF1 <- dataCreate()

head(myDF1)
library(reshape2)
melt(myDF1)# places it in a format that can be used to perform an anova
