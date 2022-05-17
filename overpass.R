library(overpass)
library(tidyverse)
library(sf)
shp <- tigris::counties(state = "NC", cb = T)

watauga <- filter(shp, NAME == "Watauga")

bbox <- st_bbox(watauga)
query <- paste0('[out:json];(node["amenity"](', cat(as.character(bbox), sep = ","), '););(._;>;);out;')

wat_amenities <- overpass_query(query)
