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
  return(L_quadr)
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
  # var <- deparse(substitute(colnames(var)))
  
  t <- tm_shape(shp) +
    tm_polygons(
      col = var,
      palette = LISA_palette,
      border.alpha = 0,
      # border.col = "black",
      lwd = 0.75,
      colorNA = na_col
    ) + 
    tm_layout(
      inner.margins = c(0.02,0.2,0.02,0)
    )
  
  return(t)
  
}
