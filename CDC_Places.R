library(spatialreg)
library(rmarkdown)
library(rgdal)
library(sf) 
library(spdep)
library(SpatialEpi)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(stargazer)
library(sjPlot)
library(lubridate)

setwd('C:/Users/sophi/OneDrive/Documents/GitHub/AppHumanGHY/data')
Places <- read.csv('PLACES__Local_Data_for_Better_Health__ZCTA_Data_2021_release.csv')
head(Places)
Places$MeasureId
Places$ZCTA <- as.integer(Places$LocationName)
head(Places)

setwd("C:/Users/sophi/OneDrive/Documents/GreenSpace/GreenspaceMetrics")
Pop <- read.csv('NC_TotalPop_2018ACS.csv')
head(Pop)
Pop$ZCTA <- as.integer(Pop$ZCTA5CE10)
head(Pop)
nrow(Pop)

setwd('C:/Users/sophi/OneDrive/Documents/GitHub/AppHumanGHY/data')
Pop_Places <- Pop %>% left_join(Places, by=c('ZCTA'))
head(Pop_Places)
nrow(Pop_Places)
write.csv(Pop_Places, 'Pop_Places.csv')
head(Pop_Plces)


Places <- data.frame(Places) #data frame
Places$MH<-Places$MeasureId

Places<-Places%>%
  filter(MH = 'MHLTH', 'DEPRESSION', 'SLEEP')

Places<-Places %>%
  filter(!is.na(InjuryZip))%>%
  dplyr::group_by(InjuryZip,Sex,calcage,Age)%>%
  summarize(nSuicide=sum(suicide))

