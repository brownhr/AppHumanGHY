amens_by_zcta <-
  st_read("data/shp/amenities_gs_buffer.shp") %>%
  st_transform(crs) %>%
  select(name, amenity) %>%
  st_join(wnc_zcta %>%
    select(ZCTA)) %>%
  mutate(
    amenity = amenity %>%
      stringr::str_replace_all("_", " ") %>%
      stringr::str_to_title() %>%
      as.factor()
  ) %>%
  mutate(amenity = fct_collapse(amenity, Parking = levels(amenity) %>%
    str_subset("[Pp]ark"))) %>%
  st_drop_geometry() %>%
  group_by(ZCTA) %>%
  summarize(n()) %>%
  mutate(amenities_sum = rowSums(across(-ZCTA))) %>%
  select(ZCTA, amenities_sum)
