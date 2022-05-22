library(sf)
library(fs)
library(tidyverse)

parkserve_dir <- path("data/gs/ParkServe")

parkserve_files <- list.files(parkserve_dir, pattern = "\\.shp$", full.names = TRUE)


parkserve_shp <- parkserve_files %>% 
  set_names(path_ext_remove) %>% 
  map(read_sf)
