zcta_moran <- zcta_main %>% 
  st_drop_geometry() %>% 
  select(
    c(TOTPOP, MHLTH, DEPRESSION, SLEEP,
      pct_white, pct_125k, greenspace_n,
      amens_per, trail_per_area)
  ) %>% 
  map_dfr(function(x){
    v <- as.vector(x)
    moran <- moran.test(
      v, 
      listw = zcta_listw,
      alternative = "two.sided",
      zero.policy = TRUE,
      na.action = na.omit
    )
    broom::tidy(moran)
  })


zcta_moran %>% 
  select(-method, -alternative) %>% 
  mutate(across(.fns = signif)) %>% 
  mutate(
    Variable = c("Population", "Mental Health", "Depression",
                 "Sleep", "Percent White", "Income", 
                 "Greenspace Area", "Amenities", "Trails"), .before = estimate1
  ) %>% 
  write_rds("data/moran.Rds")
