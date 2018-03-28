###### sepal length
z <- data.frame(iris$Sepal.Length)
names(z) <-c("myVar")
library(ggplot2) # for graphics
library(MASS) # for maximum likelihood estimation

#Plot of Histogram Data

p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
print(p1)


#Adding Empirical Density Curve

#p1 <- ggplot(data=z, aes(x=myVar)) +
# geom_density(color="grey60",fill="cornsilk",size=0.2) 
#print(p1)
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
print(p1)

# Get Max liklihood parameters for normal
normPars <- fitdistr(z$myVar,"normal")
print(normPars)
#mean          sd    
#5.84333333   0.82530129 
#(0.06738557) (0.04764879)
str(normPars)
normPars$estimate["mean"] # note structure of getting a named attribute
#   mean   is 5.843333


#Plot normal probability density

meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(z$myVar),len=length(z$myVar))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(z$myVar), args = list(mean = meanML, sd = sdML))
p1 + stat



#Plot exponential probability density

expoPars <- fitdistr(z$myVar,"exponential")
rateML <- expoPars$estimate["rate"]

stat2 <- stat_function(aes(x = xval, y = ..y..), fun = dexp, colour="blue", n = length(z$myVar), args = list(rate=rateML))
p1 + stat + stat2


#Plot uniform probability density

stat3 <- stat_function(aes(x = xval, y = ..y..), fun = dunif, colour="darkgreen", n = length(z$myVar), args = list(min=min(z$myVar), max=max(z$myVar)))
p1 + stat + stat2 + stat3

#Plot gamma probability density

gammaPars <- fitdistr(z$myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]
stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="goldenrod", n = length(z$myVar), args = list(shape=shapeML, rate=rateML))
p1 + stat + stat2 + stat3 + stat4

normPars$loglik
gammaPars$loglik
expoPars$loglik

#Therefore gamma is the best fit!

#Now I will simulate my own data:

z <- rgamma(n=150,shape=shapeML,rate=rateML)
z <- data.frame(1:150,z)
names(z) <- list("ID","myVar")
#znew <- z[znew$myVar>0,]
str(z)

#And plot a gamma distribution:

p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
gammaPars <- fitdistr(z$myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]
stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="goldenrod", n = length(z$myVar), args = list(shape=shapeML, rate=rateML))
p1 + stat4


#Compared to a gamma distribution of my data set:

z <- data.frame(iris$Sepal.Length)
names(z) <-c("myVar")
p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
gammaPars <- fitdistr(z$myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]
stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="goldenrod", n = length(z$myVar), args = list(shape=shapeML, rate=rateML))
p1 + stat4


View(iris)
#### for sepal width:

z <- data.frame(iris$Sepal.Width)
names(z) <-c("myVar")
library(ggplot2) # for graphics
library(MASS) # for maximum likelihood estimation

#Plot of Histogram Data

p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
print(p1)


#Adding Empirical Density Curve

#p1 <- ggplot(data=z, aes(x=myVar)) +
# geom_density(color="grey60",fill="cornsilk",size=0.2) 
#print(p1)
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
print(p1)

# Get Max liklihood parameters for normal
normPars <- fitdistr(z$myVar,"normal")
print(normPars)
#mean          sd    
#3.0573333   0.43441097 
#(0.06738557) (0.04764879)
str(normPars)
normPars$estimate["mean"] # note structure of getting a named attribute
#   mean   is 3.05


#Plot normal probability density

meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(z$myVar),len=length(z$myVar))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(z$myVar), args = list(mean = meanML, sd = sdML))
p1 + stat



#Plot exponential probability density

expoPars <- fitdistr(z$myVar,"exponential")
rateML <- expoPars$estimate["rate"]

stat2 <- stat_function(aes(x = xval, y = ..y..), fun = dexp, colour="blue", n = length(z$myVar), args = list(rate=rateML))
p1 + stat + stat2


#Plot uniform probability density

stat3 <- stat_function(aes(x = xval, y = ..y..), fun = dunif, colour="darkgreen", n = length(z$myVar), args = list(min=min(z$myVar), max=max(z$myVar)))
p1 + stat + stat2 + stat3

#Plot gamma probability density

gammaPars <- fitdistr(z$myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]
stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="goldenrod", n = length(z$myVar), args = list(shape=shapeML, rate=rateML))
p1 + stat + stat2 + stat3 + stat4

normPars$loglik
gammaPars$loglik
expoPars$loglik

#Therefore gamma is the best fit!

#Now I will simulate my own data:

z <- rgamma(n=150,shape=shapeML,rate=rateML)
z <- data.frame(1:150,z)
names(z) <- list("ID","myVar")
#znew <- z[znew$myVar>0,]
str(z)

#And plot a gamma distribution:

p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
gammaPars <- fitdistr(z$myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]
stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="goldenrod", n = length(z$myVar), args = list(shape=shapeML, rate=rateML))
p1 + stat4


#Compared to a gamma distribution of my data set:

z <- data.frame(iris$Sepal.Length)
names(z) <-c("myVar")
p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
gammaPars <- fitdistr(z$myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]
stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="goldenrod", n = length(z$myVar), args = list(shape=shapeML, rate=rateML))
p1 + stat4

