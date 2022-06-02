zcta_main <-
  left_join(
    places_zcta,
    trail_summary %>% st_drop_geometry() %>% select(ZCTA, sum_length),
    by = c("ZCTA" = "ZCTA")
  ) %>% 
  rename(trail_sum = sum_length) #%>% 
  # replace_na(list(trail_sum = 0))



zcta_main <- zcta_main %>% 
  mutate(
    area = st_area(zcta_main) %>% 
      set_units(km^2),
    trail_sum = set_units(trail_sum, m) %>% 
      set_units(km)
  ) %>% 
  left_join(NDVI_summary %>% st_drop_geometry() %>% select(ZCTA, NDVI_MEAN))

