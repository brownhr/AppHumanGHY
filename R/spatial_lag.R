library(spdep)
library(spatialreg)
library(broom)
library(texreg)

source("R/LISA.R")
source("R/neighbors.R")



# lm_test <- lm.LMtests(mhealth_basic,
#   listw = zcta_listw,
#   zero.policy = TRUE,
#   test = "all"
# )
# lagrange_sum <- summary(lm_test)

mhealth_lag <- lagsarlm(
  formula = MHLTH ~ NDVI_MEAN +
    greenspace_n +
    pct_white +
    # pct_125k +
    # amens_per +
    trail_per_area,
  data = zcta_main,
  listw = zcta_listw,
  zero.policy = TRUE,
  na.action = na.omit
)


depress_lag <- lagsarlm(
  formula = DEPRESSION ~ NDVI_MEAN +
    greenspace_n +
    pct_white +
    # pct_125k +
    # amens_per +
    trail_per_area,
  data = zcta_main,
  listw = zcta_listw,
  zero.policy = TRUE,
  na.action = na.omit
)

sleep_lag <- lagsarlm(
  formula = SLEEP ~ NDVI_MEAN +
    greenspace_n +
    pct_white +
    # pct_125k +
    # amens_per +
    trail_per_area,
  data = zcta_main,
  listw = zcta_listw,
  zero.policy = TRUE,
  na.action = na.omit
)

model_list <- list(mhealth_lag,
                   depress_lag,
                   sleep_lag)

write_rds(model_list, "model_list.Rds")
