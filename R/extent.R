extent <- wnc_zcta %>% 
  st_make_valid() %>% 
  # st_buffer(dist = 100) %>% 
  st_union(by_feature = F) %>% 
  sfheaders::sf_remove_holes()

write_sf(extent, "data/shp/extent.shp")
