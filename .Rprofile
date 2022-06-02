source("renv/activate.R")
library(sf)
library(tidyverse)
library(fs)
library(units)

# NAD 83 / North Carolina: use sf::st_crs("EPSG:32119") for more info

crs <- "EPSG:32119"



# This function is my late-night attempt at a convenience wrapper for write_sf
# for multiple output formats, and only requires the R object to be named. By
# default, it writes both a .kml (which I use internally, as it doesn't truncate
# column names), and .shp (for easier compatability with ArcGIS Pro, and is
# likely what everyone is most familiar with). Also, writes to the "data/" dir
# by default, but I wanted an option to change this if I wanted (might put this
# function in excess ;) )

# There's actually a bug in either sf or GDAL where the driver for KML messes up the file names, so I've wasted another hour of my evening on this :)

write_sf2 <-
  function(sf,
           dir = "data",
           drivers = c("gpkg", "shp"),
           name = deparse(substitute(sf))) {
    dir <- as_fs_path(dir)
    filename <- name

    files <- map(
      drivers,
      function(x) {
        sf_dir <- path(dir, x)
        if (!dir_exists(sf_dir)) {
          dir_create(sf_dir)
        }
        file <- path_ext_set(path(sf_dir, filename), x)
      
          st_write(sf, file, append = FALSE)
        
      }
    )
  }

# Extra st_transform calls to make absolutely sure that all the shapefiles are
# in the same CRS. They should be, as I've written them to a file with the right
# CRS, but you can never be too sure on this and I don't want to mess up our
# analysis because of a simple mistake like this.

wnc_zcta <- st_read("data/gpkg/wnc_zcta.gpkg") %>%
  st_transform(crs)

wnc_extent <- st_read("data/gpkg/wnc_extent.gpkg") %>%
  st_transform(crs)

amenities_wnc <- st_read("data/gpkg/amenities_wnc.gpkg") %>%
  st_transform(crs)

amenities_by_zcta <- st_read("data/gpkg/amenities_by_zcta.gpkg") %>% 
  st_transform(crs)

padus_wnc <- st_read("data/gpkg/padus_wnc.gpkg") %>%
  st_transform(crs)

places_zcta <- st_read("data/gpkg/places_zcta.gpkg") %>% 
  st_transform(crs)

NDVI_summary <- st_read("data/shp/zcta_NDVI.shp") %>% 
  st_transform(crs)

trail_summary <- st_read("data/shp/trail_summary2.shp") %>% 
  st_transform(crs)



