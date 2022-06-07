zcta_pri <- read_csv("data/ZCTA_Pop_Race_Income.csv",
                     col_types = list(
                       col_character(),
                       col_number(),
                       col_number(),
                       col_number()
                     ))

zcta_pri <- zcta_pri %>% 
  rename(
    population = Population.x,
    pct_white  = PCT_White,
    pct_125k = PCT_Over125K
  )
