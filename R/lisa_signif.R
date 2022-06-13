zcta_lisa2 <- zcta_main %>% 
  st_drop_geometry() %>% 
  select(
    MHLTH, DEPRESSION, SLEEP,
    greenspace_n, trail_per_area, pct_white
  ) %>% 
  mutate(across(.fns = as.numeric)) %>% 
  mutate(across(everything(), .fns = function(x){x %>% replace_na(replace = 0)})) %>% 
  mutate(across(everything(), .fns = LISA, .names = "{.col}_LISA"))

zcta_lisa_list <- zcta_lisa2 %>% 
  select(!ends_with("_LISA")) %>%
  map(function(x){
    localmoran(x = x,
               listw = zcta_listw,
               na.action = na.fail,
               zero.policy = TRUE)
  })


sig_level <- 0.05

map(.x = zcta_lisa_list,
    function(.x) {
      x_q <- attr(.x, "quadr")[, 1]
      x_p <- .x[, 5]
      .x$Quadr_Sig = if_else()
      
    }) 
