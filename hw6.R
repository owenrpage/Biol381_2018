z <- rgamma(n=150,shape=shapeML,rate=rateML)
z <- data.frame(1:150,z)
names(z) <- list("ID","myVar")
#znew <- z[znew$myVar>0,]
str(z)

p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
print(p1)
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
print(p1)
gammaPars <- fitdistr(z$myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]
stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="goldenrod", n = length(z$myVar), args = list(shape=shapeML, rate=rateML))
p1 + stat4