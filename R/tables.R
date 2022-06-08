library(knitr)
library(stargazer)
library(readr)

mhealth_lag <- read_rds("data/rds/mhealth.Rds")
depress_lag <- read_rds("data/rds/depress.Rds")
sleep_lag <- read_rds("data/rds/sleep.Rds")



stargazer_to_png <- function(input, dir) {
  name <- deparse(substitute(input))
  file <- fs::path(dir, name)
  file_html <- fs::path_ext_set(file, ".html")
  file_png <- fs::path_ext_set(file, ".png")
  
  out <- capture.output(
    stargazer::stargazer(input, type = "html", header = FALSE )
  )
  cat(paste(out, collapse = "\n"), "\n", file = file_html)
  webshot::webshot(
    url = file_html,
    file = file_png
  )
}
library(tidyverse)
list(mhealth_lag, depress_lag, sleep_lag) %>% 
  purrr::iwalk(
    function(x, .y){
      t <- summary(x)
      temp <- tempfile(fileext = ".html")
      stargazer::stargazer(
        t, type = "html", header = FALSE,
        out = temp)
      name <- .y
      
      
      webshot::webshot(url = fs::path(temp),
                       file = paste0("fig/",name, ".png"),
                       selector = "tbody")
      fs::file_delete(temp)
    }
  )
  
