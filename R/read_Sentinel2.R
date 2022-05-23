library(raster)
library(geojsonsf)
library(sen2r)

sen_dir <-
  path("C:/Users/brownhr/Documents/bda/Bulk Order SEG_SEN2/Sentinel-2")

sen_dirs <- dir_ls(sen_dir, regexp = "\\.SAFE")


# library(furrr)
# future::plan(multisession)
# 
# sen_dirs %>%
#   future_walk(function(x) {
#     sen2r::s2_translate(
#       infile = x,
#       format = "GTiff",
#       res = "10m",
#       overwrite = TRUE
#     )
#   })

sent_tif <- list.files(sen_dir, pattern = "\\.tif$", full.names = TRUE)

sent <- raster::raster(sent_tif[[1]])
