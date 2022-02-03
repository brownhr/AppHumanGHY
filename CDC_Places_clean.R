# Put all library() calls in the .Rprofile file :) They'll run on startup


PLACES_ZCTA <- read_csv("data/PLACES_ZCTA.csv") %>%
  dplyr::select(
    Year,
    LocationName,
    Category,
    Measure,
    Data_Value,
    Low_Confidence_Limit,
    High_Confidence_Limit,
    TotalPopulation,
    Geolocation,
    MeasureId
  )


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

