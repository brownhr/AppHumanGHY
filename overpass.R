# library(tmap)
library(osmdata)
library(tidyverse)
library(sf)

wnc_zcta <- read_sf("data/shp/wnc_zcta.shp") %>%
  st_transform(crs = st_crs("EPSG:4326"))

wnc_bbox <- st_bbox(wnc_zcta)

get_amenities <- function(bbox) {
  q <- opq(bbox = unname(bbox),
           timeout = 60) %>%
    add_osm_feature(key = "amenity") %>%
    osmdata_sf() %>%
    unique_osmdata()
}

get_centroids <- function(shp) {
  centroids <- shp[4:7] %>%
    map(~ mutate(.x,
      geometry = st_centroid(st_make_valid(geometry))
    )) %>%
    bind_rows() %>%
    select(osm_id, name, amenity, geometry)
  return(centroids)
}

wnc_amenities <- wnc_bbox %>%
  get_amenities()

wnc_amenities_2 <- wnc_amenities %>% 
  get_centroids() %>%
  select(osm_id, name, amenity, geometry) %>%
  st_filter(wnc_zcta)

write_sf(wnc_amenities_2, "data/shp/wnc_amenities.shp")


# wnc_amenities <- read_sf("data/shp/wnc_amenities.shp")
