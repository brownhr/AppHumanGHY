# library(tmap)
library(osmdata)


wnc_bbox <- wnc_zcta %>%
  # Using a different CRS for compatability with OSM API (i.e., lat.long vs )
  st_transform(crs = st_crs("EPSG:4326")) %>% 
  st_bbox()

get_amenities <- function(bbox) {
  q <- opq(bbox = unname(bbox),
           timeout = 60) %>%
    add_osm_feature(key = "amenity") %>%
    osmdata_sf() %>%
    unique_osmdata()
}

get_centroids <- function(list) {
  centroids <- list[4:7] %>%
    map(~ mutate(.x,
      geometry = st_centroid(st_make_valid(geometry))
    )) %>%
    bind_rows()
  return(centroids)
}

wnc_amenities <- wnc_bbox %>%
  get_amenities()


wnc_amenities_2 <- wnc_amenities %>% 
  get_centroids() %>% 
  select(osm_id, name, amenity, geometry) %>%
  st_transform(crs) %>% 
  st_filter(wnc_zcta)

write_sf(wnc_amenities_2, "data/shp/amenities_wnc.shp")
