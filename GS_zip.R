library(googledrive)
library(tidyverse)
library(sf)
library(fs)

SEG_dir <- drive_get(id = "18Fp3JptsAwJ3aXavoFOvtJWNbfJhZ0lV")
GS_zip <- drive_ls(SEG_dir) %>%
  filter(name == "GS_Shapefile.zip")

gs_dir <- fs::path("data", "shp", "gs")

if (!dir.exists(gs_dir)) {
  gs_name <- "GS_zip.zip"
  dir.create(gs_dir)
  
  drive_download(GS_zip, path = fs::path(gs_dir, gs_name))
  
  unzip(
    zipfile = fs::path(gs_dir, gs_name),
    overwrite = TRUE,
    exdir = gs_dir
  )
  file_delete(path(gs_dir, gs_name))
}

# gs_shp <- read_sf(path(gs_dir, "GS_Shapefile.shp"))
