library(spdep)

zcta_neighbors <- poly2nb(zcta_main)

zcta_cent <- st_centroid(st_geometry(zcta_main))

# tm_shape(zcta_simplify) +
#   tm_graticules(alpha = 0.3) +
#   tm_borders(col = "grey70") +
#   tm_shape(nb2lines(zcta_neighbors, coords = zcta_cent)) + tm_lines(lwd = 2, col = "grey65") +
#   tm_shape(zcta_cent) + tm_dots(size = .25)


zcta_listw <- nb2listw(neighbours = zcta_neighbors,
                       style = "W",
                       zero.policy = T)

zcta_knn <- knearneigh(zcta_cent,
                       k = 4) %>% 
  knn2nb() %>% 
  nb2listw(zero.policy = T)
