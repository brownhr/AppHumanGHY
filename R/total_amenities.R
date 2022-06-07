{
  amenities_gs_buffer <-
    st_read("data/shp/amenities_gs_buffer.shp") %>%
    st_transform(crs)
  
  amens_gs_zcta <- st_join(amenities_gs_buffer %>%
                             select(name, amenity),
                           wnc_zcta %>%
                             select(ZCTA))
  
  amens_gs_zcta <- amens_gs_zcta %>%
    mutate(
      amenity = amenity %>%
        stringr::str_replace_all("_", " ") %>%
        stringr::str_to_title() %>%
        as.factor
    )
  park <- levels(amens_gs_zcta$amenity) %>% str_subset("[Pp]ark")
  
  amens_by_zcta <- amens_gs_zcta %>%
    mutate(amenity = fct_collapse(amenity, Parking = park)) %>%
    st_drop_geometry() %>%
    group_by(ZCTA) %>%
    summarize(n()) %>%
    mutate(amenities_sum = rowSums(across(-ZCTA))) %>%
    select(ZCTA, amenities_sum)
  
  
}
