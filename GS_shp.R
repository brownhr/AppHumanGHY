library(sf)
library(tidyverse)
library(tmap)

gs_shp <- read_sf("data/shp/gs/GS_Shapefile.shp") %>%
  st_make_valid() %>%
  st_transform("EPSG:32119") %>%
  st_simplify(dTolerance = 100)

wnc_gs <- gs_shp %>% 
  st_filter(wnc_zcta, .predicate = st_overlaps) %>% 
  filter(OBJECTID != 0)
