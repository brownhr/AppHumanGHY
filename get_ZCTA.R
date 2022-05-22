library(tigris)

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
) %>% 
  st_transform(crs)

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

write_sf2(wnc_counties)

# Get ZCTA for all of NC

nc_zcta <- tigris::zctas(
  state = "NC",
  year = '2010',
  cb = F
) %>% 
  st_transform(crs)


# Intersect ZCTA with sf

wnc_zcta_list <- st_intersects(
  x = nc_zcta,
  y = wnc_counties
)


wnc_zcta_all <- nc_zcta[(lengths(wnc_zcta_list) > 0), ]

wnc_zcta_simplify <- wnc_zcta_all %>% 
  st_simplify(dTolerance = 100)

wnc_zcta <- wnc_zcta_all %>% 
  dplyr::select(
    GEOID10,
    ZCTA5CE10,
    geometry
  )


write_sf2(wnc_zcta)
