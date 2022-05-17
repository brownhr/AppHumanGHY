
library(osmdata)
library(tidyverse)
library(sf)
shp <- tigris::counties(state = "NC", cb = T)

watauga <- filter(shp, NAME == "Watauga")

bbox <- st_bbox(watauga)

q <- opq(
  bbox = unname(bbox)
) %>% 
  add_osm_feature(
    key = "amenity"
  ) %>% 
  osmdata_sf()

points <- q$osm_points

points2 <- points %>% 
  head(n = 200) %>%
  select(-starts_with("addr."),
         -starts_with("contact"),
         -starts_with("gnis"),
         -amenity,
         -area,
         -description,
         -ele,
         -religion
         ) %>% 
  pivot_longer(
    cols = -c(osm_id, geometry, name),
    names_to = "amenity_type",
    values_drop_na = T,
    values_to = "key")
