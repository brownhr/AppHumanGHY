# library(scales)
# library(ggforce)



zcta_LISA <- zcta_main %>% 
  mutate(
    across(c(
      MHLTH, DEPRESSION, SLEEP,
      greenspace_n, trail_per_area,
      pct_white),
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
    Trails = trail_per_area_LISA,
    `Pct. White` = pct_white_LISA,
  )


zcta_lisa_simp %>%
  st_drop_geometry() %>%
  # select(-population_acs2018_LISA) %>%
  colnames() %>%
  lapply(
    FUN = function(x)
      tmap_LISA(
        shp = zcta_lisa_simp,
        var = x,
        greyscale = F,
        im = c(0.02, 0.02, 0.02, 0.02)
      )
  ) %>%
  tmap_arrange(
    ncol = 2,
    nrow = 3, outer.margins = c(0,0,0,0)
    ) #%>%
  tmap_save(
    filename = "fig/brownLISA.png",
    units = "in",
    width = 4.5,
    # height = 7,
    dpi = 600
  )


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
    filename = "fig/brownExtent.png",
    width = 4.5, units = "in", dpi = 600
  )

gs_extent <- st_read("data/shp/gs_extent.shp") %>% 
  st_transform(crs)



{
  # Color version = "palegreen3"
  # Greyscale version = "grey60"
  
    tm_shape(gs_extent) +
    tm_polygons(col = "grey60", border.alpha = 0) +
    tm_shape(wnc_extent, is.master = T) +
    tm_borders(lwd = 1.5) +
    
    tm_layout(outer.margins = c(0,0,0,0))
  } %>% 
  tmap_save(
    filename = "fig/brownGSExtent.png",
    width = 4.5, units = "in", dpi = 600
  )
