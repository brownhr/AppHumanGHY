wnc_amenities <- amenities_wnc %>% 
  mutate(amenity = amenity %>% str_replace_all("_", " ") %>% str_to_title() %>% as.factor())

  
# dplyr summaries *really* don't like geometry, so I just took it out to be
# re-joined later.
zcta_geom <- wnc_zcta %>% 
  select(ZCTA)


wnc_amenities_join <- wnc_amenities %>% 
  st_join(
    wnc_zcta,
    left = FALSE
  )

wnc_zcta_amenities <- wnc_amenities_join %>% 
  st_drop_geometry() %>%
  select(ZCTA, amenity) %>% 
  group_by(ZCTA) %>% 
  count(amenity) %>% 
    ungroup() %>% 
  pivot_wider(names_from = amenity, values_from = n, values_fill = 0)

wnc_zcta_amenities <- zcta_geom %>% 
  right_join(wnc_zcta_amenities)


write_sf2(wnc_zcta_amenities, name = "amenities_by_zcta")

# top_amens <- wnc_amenities %>% 
#   st_drop_geometry() %>% 
#   group_by(amenity) %>% 
#   summarize(
#     count = n()
#   )%>% 
#   ungroup() %>% 
#   na.omit() %>% 
#   arrange(desc(count))
# 
# top_20_amens <- top_amens  %>% 
#   slice_head(n = 20) %>% 
#   mutate(
#     amenity = fct_reorder(amenity, count)
#   )
# top_20_amens %>% 
#     ggplot(aes(y = amenity, x = count, fill = amenity)) + 
#   geom_col(show.legend = FALSE) +
#   geom_text(aes(label = count), nudge_x = 150) +
#   labs(
#     x = "Count",
#     y = "Amenity",
#     title = "Top 20 Amenities in Western NC"
#   ) + 
#   theme_light()
# 
# ggsave("top_amenities.png")
# 
# wnc_amenities %>% 
#   filter(amenity %in% top_20_amens$amenity) %>%
#   mutate(
#     amenity = fct_infreq(amenity)
#   ) %>% 
#   ggplot(aes(color = amenity)) + 
#   geom_sf(show.legend = TRUE) + 
#   theme_light()
# 
# ggsave("top_amens_map.png")
