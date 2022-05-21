library(tidyverse)
library(sf)
library(tmap)


places_zcta_raw <- read_sf("data/shp/places_wnc_zcta.shp") %>% 
  st_transform("EPSG:32119") %>% 
  st_simplify(dTolerance = 100)



places_zcta_vars <- places_zcta_raw %>% 
  select(
    GEOID, ZCTA, TOTPOP,
    MHLTH, DEPRESSION, SLEEP,
    geometry
  )

write_sf(places_zcta_vars, "data/shp/places_wnc_zcta.shp")
