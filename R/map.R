library(scales)
library(ggforce)

zcta_simplify <- zcta_main %>% st_simplify(dTolerance = 50) %>% 
  mutate(
    across(c(trail_sum, area), drop_units)
  )


zcta_LISA <- zcta_main %>% 
  mutate(
    across(c(
      MHLTH, DEPRESSION, SLEEP,
      greenspace_n, amens_per, trail_per_area,
      pct_white, pct_125k, population_acs2018),
      .fns = LISA, .names = "{.col}_LISA"
    )
  )

zcta_LISA %>% 
  st_drop_geometry() %>% 
  select(ends_with("_LISA")) %>% 
  colnames() %>% 
  lapply(FUN = function(x)tmap_LISA(shp = zcta_LISA, var = x)) %>% 
  tmap_arrange(ncol = 3, nrow = 3) %>% 
  tmap_save(filename = "fig/tmap_3x3.png")
