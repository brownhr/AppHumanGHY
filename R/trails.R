# trails <- st_read("data/shp/trails.shp")

trail_summary <- st_read("data/shp/trails_summary.shp")

trail_summary <- trail_summary  %>%
  mutate(
    SUM_Length = units::set_units(SUM_Length, m),
    Area = st_area(geometry) %>% 
      units::set_units(km^2)
  ) %>% 
  mutate(
    trail_per_area = SUM_Length / Area
  ) %>% 
  st_drop_geometry() %>% 
  select(ZCTA, trail_per_area)
