library(spdep)
library(spatialreg)

source("R/LISA.R")
source("R/neighbors.R")


mhealth_lag <- lagsarlm(
  formula = MHLTH ~ NDVI_MEAN + greenspace_n + pct_white + pct_125k + amens_per,
  data = zcta_main,
  listw = zcta_listw,
  zero.policy = TRUE,
  na.action = na.omit
)
mhealth_resids <- data.frame(mhealth_lag$residuals)

zcta_simplify$mhealth_resids <-
  mhealth_resids[match(row.names(zcta_main),
                       row.names(mhealth_resids)),
                 "mhealth_lag.residuals"]

dep_basic_lm <- lm(formula = DEPRESSION ~ NDVI_MEAN + greenspace_n + pct_white + pct_125k + amens_per,
                   data = zcta_main)

depress_lag <- lagsarlm(
  formula = DEPRESSION ~ NDVI_MEAN + greenspace_n + pct_white + pct_125k + amens_per,
  data = zcta_main,
  listw = zcta_listw,
  zero.policy = TRUE
)
