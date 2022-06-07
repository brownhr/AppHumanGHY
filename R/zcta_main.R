zcta_list <- list(
  places_zcta %>% select(-GEOID10),
  
  trail_summary,
  
  NDVI_summary %>%
    st_drop_geometry() %>%
    select(ZCTA, NDVI_MEAN),
  
  gs_area %>% 
    st_drop_geometry() %>% 
    rename(
      greenspace_sqkm = gs_area,
      tot_area_sqkm = Areasqkm
    ),
  
  zcta_pri %>% 
    rename(population_acs2018 = population)
)


zcta_main <- purrr::reduce(
  zcta_list,
  dplyr::left_join,
  by = "ZCTA"
) %>% 
  replace_na(list(trail_per_area = units::set_units(0, 1/km)))

zcta_main_nogeom <- zcta_main %>% 
  st_drop_geometry()
