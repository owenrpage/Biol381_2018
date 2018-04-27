
#------------------------------------------#N_e=4pidx
#############################################
# FUNCTION: PopulationAreaCurve
# creates a function for the effective population size
# input: d = vector of population densityelements of a system
#      : x = parameter for individual dispersal
#      
# output: N_E: vector of effective population size
#--------------------------------------------
PopulationAreaCurve <- function(d = 1:2000,
                             x=1.38){
  N_E <- 4*pi*d*x
  return(N_E)
}

head(PopulationAreaCurve())

PopulationAreaCurve()

#############################################
# FUNCTION: PopulationAreaPlot
# plot curve in base graphics
## input: d = vector of population densityelements of a system
#      : x = parameter for individual dispersal
# output: base graph with parameter values
#--------------------------------------------
PopulationAreaPlot <- function(d = 1:2000,
                               x=1.38){
                            
  plot(x=d, y= PopulationAreaCurve(d,x),
       type="l",
       xlab="Population density of a system",
       ylab="N_E"
       #ylim =c(0,.001),
      # xlim=c(1000,2000)
      )
  mtext(paste("d=",d, "x",x), cex=0.7)     
  
  return()
}
PopulationAreaPlot()


# now build a grid of plots each with different parameter values

#global variables
library(ggplot2)


xPars <- c(0.10,1.16,0.26,0.30, 1.38, 2.5)
Density <- 1:5
par(mfrow=c(1,6)) # create a grid of plots
for(i in 1:length(xPars)){
    
    PopulationAreaPlot(x=xPars[i])
} 


# set up model frame
modelFrame <- expand.grid(x=xPars,
                          d=Density)
head(modelFrame)
View(modelFrame)
modelFrame$N_E <- NA

# loop for filling new data frame

for (i in 1:length(xPars)){
     modelFrame[modelFrame$x==xPars[i], "N_E"] <- PopulationAreaCurve(d=Density, x=xPars[i])
  } # xPars loop
View(modelFrame)

p1<- ggplot(data=modelFrame)
p1 + geom_line(mapping=aes(x=d, y=N_E))+
  facet_grid(.~x)
p1
 


#2
#preliminaries
library(ggplot2)
library(TeachingDemos)
char2seed("lilac")

#############################################
# FUNCTION: readData
# read in or generate data frame
# input: file name (or nothing for demo
# output: 3-column data frame of observed data (ID, x, y)
#--------------------------------------------
readData <- function(z=NULL){
  if(is.null(z)){
    xVar <- iris$Sepal.Length
    yVar <- iris$Petal.Length
    dF <- data.frame(ID=seq_along(xVar), xVar, yVar)
  } #end compound statement if there isn't any input
  return(dF)
} #end function
#############################################
readData()

#############################################
# FUNCTION: getMetric
# calculate metric for randomization test
# input: 3-column data frame for regression
# output: regression slope
#--------------------------------------------
getMetric <- function(z=NULL){
  if(is.null(z)){
  xVar <- iris$Sepal.Length
  yVar <- iris$Petal.Length
  z <- data.frame(ID=seq_along(xVar), xVar, yVar)}
  
  . <- lm(z[,3]~z[,2])
  . <- summary(.)
  . <- .$coefficients[2,1]
  slope <-.
  return(slope)
}
############################################
getMetric()
x <- getMetric()

#############################################
# FUNCTION: shuffleData
# randomize data for regression analysis; decoupling association b/w x and y
# input: 3-column data frame w/ ID, xVar, yVar
# output: 3-column data frame w/ ID, xVar, yVar (but shuffled...)
#--------------------------------------------
shuffleData <- function(z=NULL){
  if(is.null(z)){  
  xVar <- iris$Sepal.Length
    yVar <- iris$Petal.Length
    z <- data.frame(ID=seq_along(xVar), xVar, yVar)}
    
  
  z[,3] <- sample(z[,3])
  return(z)
}
#############################################
shuffleData()


#############################################
# FUNCTION: getPVal
# calculate p value for observed, simulated data
# input: list of observed metric and vector of simulated metric
# output: lower, upper tail probability
#--------------------------------------------
getPVal <- function(z=NULL){
  if(is.null(z)){
    z <- list(xObs=runif(1), xSim=runif(1000)) }
  
  #nSim <- 150
  #Xsim <- rep(NA,nSim) # will hold simulated slopes
  #Xobs <- getMetric(data=iris)

  #for (i in seq_len(nSim)) {
  #  z <- list(xObs=runif(1), xSim=runif(1000)) }
  
  pLower <- mean(z[[2]] <=z[[1]])
  pUpper <- mean(z[[2]] >=z[[1]])
  
     #   Xsim[i] <- getMetric(shuffleData(z)) }  
  #  z <- list(Xobs, Xsim)
#  pLower <- mean(z[[2]] <=z[[1]])
 # pUpper <- mean(z[[2]] >=z[[1]])
  
  return(c(pL=pLower, pU=pUpper))
}

#############################################
getPVal()


#############################################
# FUNCTION: plotRanTest
# ggplot graph
# input: list of observed metric and vector of simulated metric
# output: ggplot graph
#--------------------------------------------
plotRanTest<- function(z=NULL){
  #xVar <- iris$Sepal.Length
  #yVar <- iris$Petal.Length
  #z <- data.frame(ID=seq_along(xVar), xVar, yVar)
  #  z <- list(XObs=runif(1), xSim=runif(1000)) 
  if(is.null(z)){
    z <- list(xObs=runif(1), xSim=runif(1000)) }
  
  dF <- data.frame(ID=seq_along(z[[2]]), 
                   simX=z[[2]])
  p1 <- ggplot(data=dF, mapping=aes(x=simX))
  p1 + geom_histogram(mapping=aes(fill=I("seagreen4"), color=I("black")))+ 
    geom_vline(aes(xintercept=z[[1]],col="blue"))
}
#############################################
plotRanTest()



# main body of code
nSim <- 1000 # number of simulations
Xsim <- rep(NA,nSim) # will hold simulated slopes
dF <- readData()
Xobs <- getMetric(dF)
for (i in seq_len(nSim)) {
  Xsim[i] <- getMetric(shuffleData(dF))}
slopes <- list(Xobs,Xsim)
getPVal(slopes)

plotRanTest(slopes)