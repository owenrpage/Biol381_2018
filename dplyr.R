library(tidyverse)
library(stringr)
library(xlsx)
install.packages("devtools")
devtools::install_github("leffj/mctoolsr")

# Stringr and automating string manipulations in R
# I. Define Functions --------------------------------------------
##################################################################
# I.1
# pkg.info() 
# returns list of info on loaded non-base R packages
pkg.info <- function() sessionInfo()$otherPkgs
pkg.info()

##################################################################
# I.2
# pkg.names() 
# returns character vector of load non-base R packages
pkg.names <- function() names(sessionInfo()$otherPkgs)
pkg.names()

##################################################################
# I.3
# require.pkgs()
# checks to see if package is installed, then installs and loads 
require.pkgs <- function(p=c('vector of','packages')){
  ifelse(!is.element(p,installed.packages()[,1]),
         sapply(p, install.packages, character.only=T),
         sapply(p, require, character.only=T))
}
require.pkgs()

##################################################################
# I.4
# detach.pkgs()
# detaches all non-base R packages
detach.pkgs <- function(){
  . <- menu(c("Yes", "No"),title="Do you want to detach all packages?")
  if(.!=1){stop('function aborted')}else{
    lapply(paste('package:',names(sessionInfo()$otherPkgs),sep=""),detach,character.only=TRUE,unload=TRUE)
  }
}
detach.pkgs()
######################################################################
# I.5
# find.links()
# searches for hyperlinks (http...) in character strings
find.links <- function(x){
  require('stringr')
  require('magrittr')
  str_extract_all(x,"http[^[:space:]]*") %>% unlist()
}

##################################################################
# I.6
# file.remove.warning
# insert warning requiring user feedback before deleting a vector of files
file.remove.warning <- function(x=NULL){
  xfiles <- paste(x,collapse=', ')
  warning <- paste("WARNING: Do you want to delete",xfiles,"from the following path? \n",getwd())
  . <- menu(c("Yes", "No"),title=warning)
  if(.!=1){stop('function aborted')}else{
    cat("deleting files...")
    file.remove(x)
  }
}
file.remove.warning()

##################################################################
# I.7
# parent.dir()'
# returns the parent of working directory
parent.dir <- function(){
  require('stringr')
  require('magrittr')
  x <- getwd()
  # get names of subdirectories
  x <- str_split(x,"/") %>% unlist()
  # get path minus working directory folder 
  x <- str_c(x[-length(x)],collapse='/')
  return(x)
}
parent.dir()
Preliminaries
# II. Preliminaries ----------------------------------------------
set.seed(1) #for repeatable random numbers
Detach non-base R packages

pkg.names 
pkg.names() #I.2
detach.pkgs 
detach.pkgs() #I.4
load a vector of packages

require.pkgs 
require.pkgs(c('stringr','magrittr','openxlsx'))#I.3
pkg.names()
stringr practice
# III. `stringr` practice ---------------------------

# start by getting some strings to work with 

# vector of package names
s1 <- pkg.names()
s1
# capture.output() of console as character vector 
pkg.info
s2 <- capture.output(pkg.info()) #I.1
s2 

# this list is a little long lets subset a random sample 
s3 <- sample(s2,5,replace=FALSE)
s3


#random sample of s2
s3 <- sample(s2,5,replace=FALSE)
s3

# character length of a vector of stringr

str_length(s3)
str_length

str_wrap(s3,1)
str_warp(s1,1)

#retyrbs TRUE if arg is element

str_detect(s3,'a')

str_replace(s3,'a','(>*_*)>')

# str_trim to remove space on edges
str_trim(s3)
s3

#str_split split on a character

str_split(s3,' ')

#str_sub subsets a line or single character string on a start and end position
str_sub(s1,1,3)
str_sub(s3,-5,8) # if you structure right you can grab text in reverse order

# similar to paste but more complex
str_c(s1,s3, sep='%>%') #creates warning
str_c(s1, sep='%>%') # doesnt do anything
str_c(s1,collapse='%>%')

#works with pipes
str_trim(s3) %>%
  str_split(' ') %>%
  unlist() %>%
  str_to_upper()


#Regular expressions
str_extract_all(s2, 'http[^[:space:]]*' %>% unlist()
mylinks <- find.links(s2)                


# Crash course on dplyr
library(dplyr)
library(TeachingDemos)
char2seed('Aunt Marge')
hP <- read.csv('HarryPotter.csv')

glimpse(hP)

#subset observations (rows)
# 1. filter() return rows that satisfy a condition/many conditions
#filter the rows for the weasley family

  hP2 <- hP %>%
  filter(Last.Name=='Weasley') %>%
  print(hP2)

  hP %>%
    filter(Last.Name =='Weasley', BirthYear >= 1980)
  
  #random sample/selection of rows
  #sample_n()
  #sample_frac()
  
  # sample_frac sample 10% of the rows in the entire dataset
  sample_frac(hP, size=0.1, replace=FALSE)
  
  #sample_n
  hP %>%
    filter(Blood_Status =='HalfBlood', Sex=='Female') 
sample_n(hP,size=2, replace=FALSE)  

# re-order rows the function called arrange()

output = hP %>%
  filter(Blood_Status=='PureBlood', Sex=='Male') %>%
  arrange(Last.Name, First.Name)
print(output)

#subset variables (columns)
# select specific columns directly 
output = hP %>%
  select(First.Name, House)
print(output)

hP %>% 
  select(First.Name, House) %>%
  head 

# select all columns except a specific one
hP %>%
  select(-Sex) %>%
  head(8)
# select a range of columns
hP %>%
  select(Last.Name:House)%>%
  head

# select helper functions

# select columns sharing similar names
#'ends_with'

hP %>% 
  select(ends_with('Name')) %>% 
  head

# regular expression 
hP %>%
  select(matches('\\.')) %>%
  head

# create a new variable/col
#mutate() and transmute()

# add a new column called 'Name'
#frist and last name combined

#add a new column called 'Age' (2018-BirthYear)

output = hP %>%
  mutate(Name= paste(First.Name, '_', Last.Name), 
         Age=(2018-BirthYear))
print(output)

names= hP %>%
  transmute(Name = paste(First.Name, ' ', Last.Name))
head(names)

# summarise data 
# summarise() create summary stats for a given col or cols in the data frame
#group_by() will group/split the data

# 1. split data by house, 2. take average height of people in houses, 3. take max height, 4. provide the toatal number of obs. providing data for a particular house

hP %>%
  group_by(House) %>%
  summarise(ave_height=mean(Height),
            tallest=max(Height),
            total_ppl=n())
View(hP)

hP %>%
  select(Sex, Blood_Status, Height) %>% 
  filter(Sex=='Male', Blood_Status=='PureBlood') %>%
  filter(Height > 67, Height <72) %>%
  arrange(desc(Height))
