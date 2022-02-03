library(tigris)
library(sf)
library(dplyr)

# Get ZCTA for Western NC

# Simple list of the counties within WNC [@wnc_state_geography]
wnc_counties_list <- c(
  "Alleghany",
  "Ashe",
  "Avery",
  "Buncombe",
  "Burke",
  "Caldwell",
  "Cherokee",
  "Clay",
  "Graham",
  "Haywood",
  "Henderson",
  "Jackson",
  "Macon",
  "Madison",
  "McDowell",
  "Mitchell",
  "Polk",
  "Rutherford",
  "Swain",
  "Transylvania",
  "Watauga",
  "Wilkes",
  "Yancey"
)

nc_counties <- tigris::counties(
  state = "NC",
  cb = T
)

# Find counties in WNC

wnc_counties <- nc_counties %>% 
  # Filter by counties within wnc_counties_list
  dplyr::filter(
    NAME %in% wnc_counties_list
  ) %>% 
  # Most of the data is unnecessary; just pull out
  # whatever we need (NAME, GEOID, and geometry)
  dplyr::select(
    GEOID, NAME, geometry
  )

# Save the results to a file so we can use this later

st_write(
  obj = wnc_counties,
  dsn = "data/shp/wnc_counties.shp"
)



  # Intersect ZCTA with sf