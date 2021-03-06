padus_dir <- path("data/gs/PADUS")

padus_files <- list.files(padus_dir, pattern = "\\.shp$", full.names = TRUE)


padus_shp <- padus_files[-4] %>% 
  set_names(basename) %>% 
  map(read_sf)

padus_join <- padus_shp %>% 
  map_dfr(bind_rows) %>% 
  st_transform(crs)

padus_wnc <- padus_join %>% 
  st_filter(wnc_zcta) %>% 
  st_make_valid()

padus_wnc_2 <- padus_wnc %>% 
  st_intersection(wnc_extent)

padus_wnc_3 <- padus_wnc_2 %>%
  select(
    Category,
    Mang_Type,
    Mang_Name,
    Loc_Mang,
    Des_Tp,
    d_Des_Tp,
    Unit_Nm,
    Loc_Nm,
    GAP_Sts,
    d_GAP_Sts,
    IUCN_Cat,
    d_IUCN_Cat
  )


write_sf2(padus_wnc_3, name = "padus_wnc")
