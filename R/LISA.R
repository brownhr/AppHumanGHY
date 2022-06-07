library(tmap)


LISA <- function(sp_var, quadr = T) {
  L <- spdep::localmoran(
    x = as.vector(sp_var),
    listw = zcta_listw,
    zero.policy = T,
    na.action = na.pass,
    alternative = "two.sided"
  )
  L_quadr <- attr(L, "quadr")[, 1]
  levels(L_quadr) <-
    c("Low-Low", "Low-High", "High-Low", "High-High")
  return(L)
}


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
  var <- names(select(shp, {{var}}))[[1]]
  
  t <- tm_shape(shp) +
    tm_polygons(

      col = var,
      palette = LISA_palette,
      border.alpha = 0.3,
      border.col = "white",
      colorNA = na_col,
      lwd = 1.5
    )
  
  return(t)
  
}






# LISA_list <-
#   c("MHLTH_LISA",
#     "DEPRESSION_LISA",
#     "SLEEP_LISA",
#     "NDVI_MEAN_LISA") %>%
#   map( ~ tmap_LISA(
#     shp = zcta_main2 %>% st_simplify(dTolerance = 50),
#     var = .x,
#     greyscale = T
#   ))

# 
# lisa_tmap_list <- tmap_arrange(LISA_list)
# lisa_tmap_list
# 
# tmap_save(
#   lisa_tmap_list,
#   filename = "fig/multi_LISA_greyscale.png",
#   dpi = 300,
#   width = 10,
#   height = 7.5
# )
