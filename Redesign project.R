#Calling necessary packages
library(tidyverse)
library(micromapST)

#Calling Dataset
db <- read_csv("C:/Users/ahnj9/OneDrive/Desktop/2020/515/Redesign project/nst-est2019-alldata.csv")
pop <- as.data.frame(cbind(db$NAME,db$CENSUS2010POP, db$POPESTIMATE2019,db$POPESTIMATE2019-db$CENSUS2010POP,
                           db$POPESTIMATE2019/as.integer(db[1,17])))
colnames(pop) <- c('State','2010POP','2019POP','POPChange2010-2019', 'Prop')
pop
dim(pop)
pop$Zero <- rep(0,nrow(pop))

head(pop)
#Creating Panel Description
panel <- data.frame(
  type = c('mapcum','id', 'bar', 'bar','arrow','dot'),
  col1 = c(NA, NA, 2, 3, 6, 5),
  col2 = c(NA, NA, NA, NA, 4, NA),
  lab1 = c(NA, NA, 'Population', 'Population','Change in',''),
  lab2 = c('', '', 'in 2010', 'in 2019','Population','Proportion')
)

#Apply MicromapST
ffName = "pop.pdf"
pdf(file=ffName,width=7.5,height=10)
micromapST(pop, panel, rowNames = 'full', 
           rowNamesCol='State',
           title =c('U.S. Population and Changes in 2010-2019'),
           plotNames = 'full',
           ignoreNoMatches=TRUE,
           bordGrp = 'USStatesBG',
           sortVar ='2019POP',
           ascend=TRUE,
           axisScale = 'sn'
)
dev.off()

