# Basic R commands and usage
# 30 January 2018
# Owen R. Page
library(ggplot2)
# Using the assignment operator

x <-5 # preferred
print(x)
y = 4 # legal but not used except in a function
y
plantHeight <- 5.5

#----------------- end 1/30/18------------

#---------------start 2/2/18--------------

# the combine function
z <- c(3,7,7,10) # simple atomic vector
print(z)
typeof(z) # use to get the variable type
#integers and doubles are both numeric
str(z) # get structure of the variable

is.numeric(z) # logical test for variable type
is.character(z) 

# c always "flattens" to an atomic vector

z <- c(c(3,4),c(5,6))
print(z)


# Character strings with single or double quotes
z<- c('perch', 'bass', 'trout', 'red snapper')
print(z)

# use both quote types for an internal quote
z <- c("this is only 'one' character string", 'a second string')
str(z)

# logical variables TRUE/FALSE
z <- c(TRUE, TRUE, FALSE)
str(z)
is.numeric(z)
is.logical(z) # once again testing the variable type

# Three properties of atomic vectors
# 1. Type of atomic vector
z <- c(1.1,2.2,3.2)
typeof(z)
is.numeric(z)

#2. Length of vector
length(z)

#3. Name of vector elements (optional)
z <- runif(5) # random uniform variable (0,1)
names(z) #NULL because in initial state we have not assigned any names
# add names after variable is created
names(z) <- c("chow", 'pug', 'beagle', 'greyhound', 'akita')
print(z)

# can also add names when the variablei s built 
z2 <- c(gold= 3.3, silver=10, lead=2)
print(z2)
names(z2) <- NULL # to reset the names
print(z2)
names(z2) <- c("copper", 'zinc')
print(z2)

# special data values 

# NA for missing values
z <- c(3.22,3.3, NA)
length(z)
typeof(z[3]) # use brackets to specify piece you want to look at
#missing values can trip up basic functions
mean(z) # gives us NA
is.na(z) # checks for missing values
!is.na(z) #! is the NOT
mean(!is.na(z)) # WRONG -- calculates mean of TRUE/FALSE values (for TRUE)
mean(z[!is.na(z)]) # so do it this way

# NaN, Inf, -Inf
# bad results from numeric calculations
z <- 0/0
print(z)
z <- (1/0)
print(z)
z <- (-1/0)
print(z)
z <- 0/1
print(z) #okay
z <- 1/0
typeof(z) # still gives us the type

# NULL is an object that is nothing! Kind of acts as a blank variable
z <- NULL
typeof(z)
length(z)
is.null(z) # the only thing is NULL

# Three properties of atomic vectors
#1. Coercion
a <- c(2.1,2.2)
typeof(a)
b <- c('purple', 'green')
typeof(b)
d <- c(a,b)
print(d)
typeof(d) # now character, numeric values from a have been coerced into the same type-- character
# hierarchy of conversion: 
#logical -> integers -> doubles -> character

a <- runif(10)
print(a)
a > 0.5   # logical operation # greater-than sign
temp <- a > 0.5 # hold these logical values
sum(temp)
# What proportion of the values are > 0.5 
mean(a > 0.5)

# qualifying exam question: approximately what proportion of observations from a normal (0,1) random variable are >2.0
mean(rnorm(1000000)>2.0)

#2. vectorization
z <- c(10,20,30)
z + 1
y <- c(1,2,3)
z+y # element-by-element matching
z*y
short <- c(1,2)
z+ short # yields a warning message but still runs the code and recycles the 1 after the 2 is used so we get 10+1, 20+2, 30+1
z^2

# creating vectors
#create an empty vector
z <- vector(mode="numeric", length=0)
print(z)

# add elements to empty vector
z <- c(z,5) # Don't do this in your code
print(z)
# instead create a vector of pre-defined length
z <- rep(0,100)
z[1] <- 3.3
head(z)
z <- (rep(NA,100)) # safer way to do it
head(z)
typeof(z)
z[c(1,2)] <- c('Washington', 2.2) # remaining NA values are now character NAs
head(z)
z[c(1:20)] <- c('Washington', 2.2)
z[1:30]

#generate a long list of names
myVector <- runif(15) # get 100 random uniform values
myNames <- paste("File", seq(1:length(myVector)),".csv", sep= "")
head(myNames)
names(myVector) <- myNames
head(myVector)

# using rep to repeat elements and create vectors 

#-------------------------- 2/1/18 end----------------
#-------------------2/6/18 start---------------
# used to repeat the first atomic vector x amount of times 
rep(x=0.5,times=6)

myVec <- c(1,2,3) # doing rep with a vector 123 123 
rep(myVec, times=2)
rep(myVec, each=2) # repeats numbers together groups 111 222 333
rep(x=myVec,times=myVec) # 1 2 2 3 3 3 repeat myVec in style of myVec 
rep(x=1:3, times=3:1) # 111 22 3, notice the similarity with the above line?

# seq for creating sequences, non-repeating sequences
seq(from=2, to=4)               # 2 3 4 
seq(from=2, to=4, by=0.5)       #2.0 2.5 3.0 3.5 4.0
seq(from=2, to=4, length=7)     # 2.00 2.33 2.66 3.00 3.33 3.66 4.00
x <- seq(from=2, to=4, length=7)
1:length(x)                     # use to find length of elements in vector
seq_along(x)      # faster, better than line above
1:5
seq(1,5)  #these two functions are the same thing
seq_len(10)
x<- vector(mode="numeric", length=0)
str(x)                 # num(0)
1:length(x)            # 1  0, not what we want andd will generate issues later on
seq_along(x)           # gives integer(0), this is how it should be

# using random numbers
runif(1)
set.seed(100)
runif(1)
runif(n=5, min=100, max=200)
library(ggplot2)
z<- runif(n=1000, min=30, max=300)
qplot(x=z)
# random normal values
z <- rnorm(1000)
qplot(z)
z <- rnorm(1000, mean=30, sd=20)
qplot(x=z)

# use sampple function to draw from an existing vector
longVec <- seq_len(10)
longVec
sample(x=longVec)
sample(x=longVec, size=3) # sample without replacement
sample(x=longVec, size=3, replace=TRUE)
myWeights <- c(rep(20,5),rep(100,5)) # gives 5:1 element bias
sample(x=longVec, replace= TRUE, prob= myWeights)

sample(x=longVec, replace= FALSE, prob= myWeights)

#subsetting of atomic vectors
z <- c(3.1,9.2,1.3,0.4,7.5) 

# subsetting on poisitve index values
z[2]  # 9.2
z[c(2,3)]   #9.2 1.3 
#subset on negative index values
z[-c(2,3)] # gives all the values not listed

#subset by creating a boolean vector to select elements that meet a condition

z<3  # F F T T F 
z[z<3] # 1.3 0.4, the (TT)
which(z<3) # 3 4, or elements 3,4-- gives index values that meet the condition
myCriteria <- z<3
z[myCriteria]  # 1.3, 0.4
z[which(z<3)] # 1.3, 0.4
zx <- c(NA,z)
zx[zx<3] # missing values kept in list
zx[which(zx<3)] # missing values dropped out

# keep entire vector
z[]
z[-(length(z):(length(z)-2))] # says get rid of 5 to 3 (543) --> 3.1 9.2

# subset on names of cextor elements
z
names(z) <-letters[seq_along(z)]
z
z[c('b','d','e')]

# arithmetic operators
10 + 3
10 - 3
10 * 3
10 / 3
10^3
log(10)  # log=ln
log10(10) # log is base 10

#modulus operator (remainder of division)
10 %% 3 #1
#integer division
10 %/% 3
#generate the set of all numbers from 1 to 100 that are divisible by 9
q <- seq_len(100)
q[q%%9==0] #q for q modulus by nine is == to zero (TRUE)

install.packages("devtools")
library(devtools)
install_github("thomasp85/patchwork")
