library(raster)

nlcd_raw <- raster("data/NLCD/NLCD_clip.tif")

nlcd_proj <- nlcd_raw %>% 
  projectRaster(crs = crs,
                res = 30,
                method = "ngb")
