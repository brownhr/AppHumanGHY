# library(scales)
# library(ggforce)

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

zcta_lisa_simp <- zcta_LISA %>% 
  st_simplify(dTolerance = 50) %>% 
  select(ends_with("_LISA")) %>% 
  rename(
    `MHLTH`= MHLTH_LISA,
    `Depression` = DEPRESSION_LISA,
    `Sleep` = SLEEP_LISA,
    `Greenspace` = greenspace_n_LISA,
    `Amenities` = amens_per_LISA,
    Trails = trail_per_area_LISA,
    `Pct. White` = pct_white_LISA,
    `Pct. 125k` = pct_125k_LISA
  )


zcta_lisa_simp %>% 
  st_drop_geometry() %>% 
  select(-population_acs2018_LISA) %>% 
  colnames() %>% 
  lapply(FUN = function(x)tmap_LISA(shp = zcta_lisa_simp, var = x, greyscale = T)) %>% 
  tmap_arrange(ncol = 2, nrow = 4) %>% 
  tmap_save(filename = "fig/brownLISA.png", units = "in",
            width = 7, height = 4.375, dpi = 300)


source("R/get_ZCTA.R", echo = T)

states <- tigris::states(cb = T)
nc_border <- states %>% 
  filter(STUSPS == "NC") %>% 
  st_transform(crs = crs)


{
  tm_shape(nc_border, is.master = T) +
    tm_borders() +

    tm_shape(nc_counties) +
    tm_polygons(col = "grey98", border.col = "grey80") +
    tm_shape(wnc_zcta) +
    tm_polygons(col = "grey95", border.col = "grey55") +
    tm_shape(wnc_extent) +
    tm_borders(lwd = 1.5) +
    tm_layout(frame = T,
              outer.margins = c(0, 0, 0, 0))
} %>%
  tmap_save(
    filename = "fig/zcta_overview.png",
    width = 4.5, units = "in", dpi = 600
  )

gs_extent <- st_read("data/shp/gs_extent.shp") %>% 
  st_transform(crs)



{
    tm_shape(gs_extent) +
    tm_polygons(col = "grey80", border.alpha = 0) +
    tm_shape(wnc_extent, is.master = T) +
    tm_borders(lwd = 1.5) +
    
    tm_layout(outer.margins = c(0,0,0,0))
  } %>% 
  tmap_save(
    filename = "fig/greenspace_extent.png",
    width = 4.5, units = "in", dpi = 600
  )
