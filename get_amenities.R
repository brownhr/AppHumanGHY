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
  st_transform(crs) %>% 
  select(osm_id, name, amenity, geometry) %>%
  st_filter(wnc_zcta)

write_sf2(wnc_amenities_2, name = "amenities_wnc")
