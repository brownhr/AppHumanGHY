source("R/neighbors.R")
source("R/LISA.R")

zcta_lisa <- zcta_main %>%
  mutate(across(-c(ZCTA, TOTPOP, population_acs2018)))


lisa_list <- zcta_lisa %>%
  st_drop_geometry() %>%
  select(ends_with("_LISA")) %>%
  names() %>%
  map(tmap_LISA,
      shp = zcta_lisa %>%
        st_simplify(dTolerance = 50),
      greyscale = F)

lisa_list %>%
  tmap_arrange(ncol = 3,
               nrow = 4) %>%
  tmap_save(filename = "fig/LISA.png",
            width = 11,
            height = 8.5)
