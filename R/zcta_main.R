zcta_list <- list(
  places_zcta %>% select(-GEOID10),
  
  trail_summary %>% 
    st_drop_geometry(),
  
  NDVI_summary %>%
    st_drop_geometry() %>%
    select(ZCTA, NDVI_MEAN),
  
  gs_area  %>% 
    rename(
      greenspace_sqkm = gs_area
    ) %>% 
    mutate(
      greenspace_sqkm = units::set_units(greenspace_sqkm, km^2),
      tot_area_sqkm = units::set_units(st_area(geometry), km^2)
    ) %>% 
    mutate(
      greenspace_n = greenspace_sqkm / tot_area_sqkm
    )%>% 
    st_drop_geometry(),
  
  zcta_pri %>% 
    rename(population_acs2018 = population)
)


zcta_main <- purrr::reduce(
  zcta_list,
  dplyr::left_join,
  by = "ZCTA"
) %>% 
  replace_na(list(trail_per_area = units::set_units(0, 1/km)))

zcta_simplify <- zcta_main %>% 
  st_simplify(dTolerance = 50)



zcta_main_nogeom <- zcta_main %>% 
  st_drop_geometry()
