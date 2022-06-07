library(scales)
library(ggforce)

zcta_simplify <- zcta_main %>% st_simplify(dTolerance = 50) %>% 
  mutate(
    across(c(trail_sum, area), drop_units)
  )

tm_shape(zcta_simplify) + 
  tm_polygons("PCT_White")



zcta_simplify %>% 
  mutate(trail_per = trail_sum/area) %>% 
  tm_shape() + 
  tm_polygons(col = "trail_per",
              palette = "Greys",
              style = "pretty") + 
  tm_layout(compass.type = "arrow",
            title = "Total Trail length in km. per sq. km.")
