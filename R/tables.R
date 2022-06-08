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
  
t <- tempfile(fileext = ".html")
stargazer::stargazer(mhealth_lag,
                     depress_lag,
                     sleep_lag,
                     header = F,
                     type = "html",
                     out = t, )

webshot2::webshot(t, "fig/table.pdf", selector = "tbody",
                  expand = 10)
