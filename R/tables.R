library(knitr)
library(spatialreg)
library(stargazer)
library(tidyverse)

mhealth_lag <- read_rds("data/rds/mhealth.Rds")
depress_lag <- read_rds("data/rds/depress.Rds")
sleep_lag <- read_rds("data/rds/sleep.Rds")

list(mhealth_lag, depress_lag, sleep_lag) %>% 
  purrr::iwalk(
    function(x, .y){
      t <- summary(x)
      temp <- tempfile(fileext = ".html")
      # temp <- "fig/out.html"
      stargazer::stargazer(
        t, type = "html", header = FALSE,
        out = temp)
      name <- .y
      
      
      webshot2::webshot(url = fs::path(temp),
                       file = paste0("fig/",name, ".png"),
                       selector = "tbody")
      fs::file_delete(temp)
    }
  )
  


model_list <- list(mhealth_lag, depress_lag, sleep_lag)
# 
# model_summary <- model_list %>% 
#   map(
# function(x)coef(summary(x))[,c(1,4)])

# t <- tempfile(fileext = ".html")
# t <- "fig/results_table.html"
# stargazer::stargazer(
#   model_list,
#   header = F,
#   type = "html",
#   out = t,
#   flip = T
# )
# 
# webshot2::webshot(t, "fig/table.pdf", selector = "tbody",
#                   expand = 10)

library(broom)
library(pander)


texreg::plotreg(model_list,
                custom.model.names = c("Mental Health", "Depression", "Sleep"),
                custom.coef.map = list(
                 "(Intercept)" = "Intercept",
                 "NDVI_MEAN" = "Mean NDVI",
                 "greenspace_n" = "GS Area",
                 "pct_white" = "% White",
                 "pct_125k" = "% > $125k",
                 "amens_per" = "Amenities",
                 "trail_per_area" = "Trails",
                 "rho" = "Rho"
                ), reorder.coef = c(1, 8, 2, 3, 4, 5, 6, 7),
                theme = theme_bw(),
                type = "forest") %>% 
  ggsave(filename = "fig/forest_reg.png",
         width = 4.5, units = "in", dpi = 600)

