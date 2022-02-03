# This is just a basic script to save the different MeasureIDs from the PLACES dataset to a separate file, cutting down on much of the filesize of the CSVs

PLACES <- read_csv("data/PLACES_ZCTA.csv") %>% 
  dplyr::select(
    Category,
    MeasureId,
    Measure
  )


PLACES_dist <- PLACES %>% 
  dplyr::distinct(
    MeasureId,
    .keep_all = T
  ) %>% 
  arrange(
    Category, MeasureId
  )

write_csv(PLACES_dist, file = "PLACES_Key.csv")
