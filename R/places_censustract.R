library(tidyverse)
library(tigris)
library(sf)
library(tmap)

crs <- "EPSG:32119"
source("R/get_ZCTA.R")

states <- c("NC", "TN", "SC", "GA", "VA", "KY")


south_ct <- states %>% 
  map_dfr(~tigris::tracts(state = .x, cb = T))



places_ct <-
  read_csv(
    "data/places_2021_censustract.csv",
    col_types = cols(
      Year = col_skip(),
      StateDesc = col_skip(),
      DataSource = col_skip(),
      Measure = col_skip(),
      Data_Value_Footnote_Symbol = col_skip(),
      Data_Value_Footnote = col_skip(),
      Low_Confidence_Limit = col_skip(),
      High_Confidence_Limit = col_skip(),
      Geolocation = col_skip(),
      CategoryID = col_skip(),
      DataValueTypeID = col_skip(),
      Short_Question_Text = col_skip()
    ),
    trim_ws = FALSE
  ) %>% 
  filter(
    StateAbbr %in% states,
    MeasureId %in% c("MHLTH", "DEPRESSION", "SLEEP")
  )


places_wide <- places_ct %>% 
  

nc_places <- left_join(nc_censustract, places_ct, by = c("GEOID" = "LocationName"))


nc_places2 <- nc_places %>% 
  select(
    GEOID, NAMELSAD, CountyName, CountyFIPS,
    Data_Value, TotalPopulation, MeasureId
  )


nc_places_wide <- nc_places2 %>% 
  pivot_wider(names_from = MeasureId, values_from = Data_Value) %>% 
  st_as_sf()


c("MHLTH", "DEPRESSION", "SLEEP") %>% 
  map(~qtm(shp = nc_places_wide, fill = .x)) %>% 
  tmap_arrange()
