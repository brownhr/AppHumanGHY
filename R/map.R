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

zcta_LISA %>% 
  st_drop_geometry() %>% 
  select(ends_with("_LISA")) %>% 
  select(-population_acs2018_LISA) %>% 
  colnames() %>% 
  lapply(FUN = function(x)tmap_LISA(shp = zcta_LISA, var = x)) %>% 
  tmap_arrange(ncol = 4, nrow = 2) %>% 
  tmap_save(filename = "fig/brownhrLISA_color.png",
            width = 7, height = 4.25, dpi = 600, asp = 0)


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
