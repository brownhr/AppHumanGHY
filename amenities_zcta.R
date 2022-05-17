library(tidyverse)
library(sf)
library(tmap)

crs <- st_crs("EPSG:4326")

wnc_zcta <- read_sf("data/shp/wnc_zcta.shp") %>% 
  st_transform(crs = crs)
wnc_amenities <- read_sf("data/shp/wnc_amenities.shp") %>% 
  st_transform(crs = crs) %>% 
  mutate(amenity = amenity %>% str_replace_all("_", " ") %>% str_to_title() %>% as.factor())

top_amens <- wnc_amenities %>% 
  st_drop_geometry() %>% 
  group_by(amenity) %>% 
  summarize(
    count = n()
  )%>% 
  ungroup() %>% 
  na.omit() %>% 
  arrange(desc(count))

top_20_amens <- top_amens  %>% 
  slice_head(n = 20) %>% 
  mutate(
    amenity = fct_reorder(amenity, count)
  )
top_20_amens %>% 
    ggplot(aes(y = amenity, x = count, fill = amenity)) + 
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = count), nudge_x = 150) +
  labs(
    x = "Count",
    y = "Amenity",
    title = "Top 20 Amenities in Western NC"
  ) + 
  theme_light()

ggsave("top_amenities.png")

wnc_amenities %>% 
  filter(amenity %in% top_20_amens$amenity) %>%
  mutate(
    amenity = fct_infreq(amenity)
  ) %>% 
  ggplot(aes(color = amenity)) + 
  geom_sf(show.legend = TRUE) + 
  theme_light()

ggsave("top_amens_map.png")
