library(lubridate)

# x days from the assigned date

diff <- make_datetime(days=150)
x <- as.Date('2009-09-02')
wday(x)
yday(x)

wday(ymd(180502))
wday(ymd(180502), label=TRUE, abbr=FALSE)
wday(ymd(180502)+days(-2:3), label=TRUE, abbr=FALSE)
duration(1.5, 'days')
duration(second=3, minute=3.5, hour=2, day=6, week=1)
duration('2d, 2H, 2M,2S')

leap_year(1996)

# create objects of a class date

make_datetime(year=1999, month=12, day=22, hour=c(10,11))

x <- seq.Date(as.Date('2009-08-02'), by = 'year', length.out=2)
x 
pretty_dates(x, 12)

#create timestamps 
M <- ymd_hms('2018-05-01 10:00:00', tz='America/New_York')+weeks(0:6)
stamp('May 1, 2018')(M)

meeting <- stamp('Meet with Carol on Tuesday, May 1, 2018 at 10:00')
meeting(M)

#----------------------------
date <- ymd('2019-01-01')
month(date) <- 11
wday(date, label=TRUE)
date <- date + days(6)
date + weeks(3)

# timevis and shiny
library(timevis)

simpleTL <- data.frame(
  id=1:4,
  content=c('Randomization Tests', 'ggPlots', 'Homework 12', 'Presentations 1'),
  start=c('2018-04-03', '2018-04-05', '2018-04-11', '2018-04-24 14:50:00'),
  end= c(NA, '2018,04,17',NA,NA))
simpleTL

timevis(simpleTL)

#add groups
# create a dataframe to define groups

groups <- data.frame(
  id=c('lec', 'hw','pt'),
  content= c('Lecture', 'Homework', 'Presentation'))
groupTL <- cbind(simpleTL, group=c(rep('lec', 2), 'hw', 'pt'))
groupTL

timevis(groupTL, groups=groups)
timevis(groupTL, groups=groups) %>% 
  addItem(list(id=5, content="<b>Presentations 2<b>", start=
'2018-04-25', group='pt'))
groupTL$content <- as.character(groupTL$content)

groupTL[3,2] <- "<a gref='http://gotellilab.io/Bio381/Homeworks/Homework_12_2018.html' >Homework 12</a>"
timevis(simpleTL, showZoom=FALSE, options=list
        (editable=TRUE, width='500px', height='400px'))

styles <- c('color:white;background-color:black;')         

#read in the data            