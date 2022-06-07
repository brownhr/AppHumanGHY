gs_area <- st_read("data/shp/gs_area.shp")

gs_area <- gs_area %>% 
  select(ZCTA,
         gs_area,
         Areasqkm)
