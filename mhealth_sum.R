places <- sf::st_read("data/shp/places_cent.shp")


mh_summaries <- places %>% 
  dplyr::select(
    ZCTA, TOTPOP, MHLTH, DEPRESSION, SLEEP 
  ) %>% 
  na.omit() %>% 
  dplyr::summarize(
    pop_sum = sum(TOTPOP),
    mhealth_sum = sum(MHLTH),
    depr_sum = sum(DEPRESSION),
    sleep_sum = sum(SLEEP)
  )
