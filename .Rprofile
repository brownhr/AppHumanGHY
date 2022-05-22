library(sf)
library(tidyverse)
library(fs)

# NAD 83 / North Carolina: use sf::st_crs("EPSG:32119") for more info

crs <- "EPSG:32119"



# This function is my late-night attempt at a convenience wrapper for write_sf
# for multiple output formats, and only requires the R object to be named. By
# default, it writes both a .kml (which I use internally, as it doesn't truncate
# column names), and .shp (for easier compatability with ArcGIS Pro, and is
# likely what everyone is most familiar with). Also, writes to the "data/" dir
# by default, but I wanted an option to change this if I wanted (might put this
# function in excess ;) )

write_sf2 <-
  function(sf,
           dir = "data",
           drivers = c("kml", "shp"),
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
        write_sf(sf, file)
      }
    )
  }

# Extra st_transform calls to make absolutely sure that all the shapefiles are
# in the same CRS. They should be, as I've written them to a file with the right
# CRS, but you can never be too sure on this and I don't want to mess up our
# analysis because of a simple mistake like this.

wnc_zcta <- read_sf("data/kml/wnc_zcta.kml") %>%
  st_transform(crs)

wnc_extent <- read_sf("data/kml/wnc_extent.kml") %>%
  st_transform(crs)

# I had to use .shp for this one because of some invalid characters in the
# dataset :(
amenities_wnc <- read_sf("data/shp/amenities_wnc.shp") %>%
  st_transform(crs)

# padus_wnc <- read_sf("data/shp/padus_wnc.shp") %>%
#   st_transform(crs)
