library(sf)
library(tidyverse)

# NAD 83 / North Carolina: use sf::st_crs("EPSG:32119") for more info

crs <- "EPSG:32119"


# Extra st_transform calls to make absolutely sure that all the shapefiles are
# in the same CRS. They should be, as I've written them to a file with the right
# CRS, but you can never be too sure on this and I don't want to mess up our
# analysis because of a simple mistake like this.

wnc_zcta <- read_sf("data/shp/places_wnc_zcta.prj") %>%
  st_transform(crs)

wnc_extent <- read_sf("data/shp/extent.shp") %>%
  st_transform(crs)

padus_wnc <- read_sf("data/shp/padus_wnc.shp") %>%
  st_transform(crs)
