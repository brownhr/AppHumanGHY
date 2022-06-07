zcta_list <- list(
  places_zcta %>% select(-GEOID10),
  trail_summary %>% st_drop_geometry() %>% select(ZCTA, sum_length),
  NDVI_summary %>% st_drop_geometry() %>% select(ZCTA, NDVI_MEAN),
  zcta_pri
)


zcta_main <- purrr::reduce(
  zcta_list,
  dplyr::left_join,
  by = "ZCTA"
)
