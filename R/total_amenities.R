total_amenities <- amenities_by_zcta %>% 
  st_drop_geometry() %>% 
  mutate(
    amen_sum = rowSums(across(-ZCTA))
  ) %>% 
  select(ZCTA, amen_sum)
