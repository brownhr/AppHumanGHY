# Put all library() calls in the .Rprofile file :) They'll run on startup


# Read PLACES data and select for relevant fields

places_zcta_all <- read_csv("data/PLACES_ZCTA.csv") %>%
  dplyr::select(
    Year,
    LocationName,
    Category,
    Data_Value,
    # Let's exclude confidence limits for now, but we could always re-add them
    # Low_Confidence_Limit,
    # High_Confidence_Limit,
    TotalPopulation,
    Geolocation,
    MeasureId
  )

# Read WNC ZCTA shapefile

wnc_zcta <- st_read("data/shp/wnc_zcta.shp")

# Filter PLACES by ZCTA in WNC

places_wnc_zcta <- left_join(wnc_zcta, places_zcta_all,
                             by = c("ZCTA5CE10" = "LocationName")) %>%
  # Remove the Geolocation field; st_centroid can be used if we need a centroid
  select(-Geolocation)


# Combining the columns 


# Save this as a shapefile




st_write(
  obj = places_wnc_zcta,
  dsn = "data/shp/places_wnc_zcta.shp",
)


places <- st_read("data/shp/places_wnc_zcta.shp")
