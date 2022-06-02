trails <- st_read("data/shp/trails.shp")

trail_summary <- st_read("data/shp/trails_summary.shp")

trail_summary <- trail_summary %>% 
  select()
