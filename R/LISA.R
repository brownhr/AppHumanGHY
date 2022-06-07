LISA <- localmoran(zcta_main$NDVI_MEAN, listw = zcta_listw)

calc_lisa <- function(data, lisa_vars){
  
  
  lisa_val <- function(sp_var){
    L <- localmoran(x = sp_var,
                    listw = zcta_listw, zero.policy = T, na.action = na.pass,
                    alternative = "two.sided")
    L_quadr <- attr(L, "quadr")[,1]
    levels(L_quadr) <- c("Low-Low", "Low-High", "High-Low", "High-High")
    return(L_quadr)
  }
  
  data %>% 
    mutate(across({{lisa_vars}}, lisa_val, .names = "{.col}_LISA" ))
  
  
}

zcta_main2 <- zcta_main %>% 
  calc_lisa(lisa_vars = c(MHLTH, DEPRESSION, SLEEP, NDVI_MEAN))

tmap_LISA <- function(shp, var, greyscale = FALSE) {
  
  if (greyscale) {
    LISA_palette <- c(
      "Low-Low" = "gray70",
      "Low-High" = "gray60",
      "High-Low" = "gray50",
      "High-High" = "gray40"
    )
    na_col <- "gray95"
  } else{
    LISA_palette <- c(
      "Low-Low" = "dodgerblue3",
      "Low-High" = "dodgerblue",
      "High-Low" = "firebrick1",
      "High-High" = "firebrick3"
    )
    na_col <- "gray80"
  }
  

  var <- deparse(substitute(var))
  t <- tm_shape(shp) +
    tm_polygons(

      col = var,
      palette = LISA_palette,
      border.alpha = 0.3,
      border.col = "white",
      colorNA = na_col,
      lwd = 1.5
    )
  
  t
  
}

LISA_list <-
  c("MHLTH_LISA",
    "DEPRESSION_LISA",
    "SLEEP_LISA",
    "NDVI_MEAN_LISA") %>%
  map( ~ tmap_LISA(
    shp = zcta_main2 %>% st_simplify(dTolerance = 50),
    var = .x,
    greyscale = T
  ))


lisa_tmap_list <- tmap_arrange(LISA_list)
lisa_tmap_list

tmap_save(
  lisa_tmap_list,
  filename = "fig/multi_LISA_greyscale.png",
  dpi = 300,
  width = 10,
  height = 7.5
)
