library(tidyverse)
library(rgdal)

wahlkreise_map <- readOGR(dsn = "RBS_OD_Wahlkreise_AH2021", stringsAsFactors = F)
wahlkreise_bez <- broom::tidy(wahlkreise_map, region = "BEZ")
wahlkreise_bez %>% 
  ggplot(aes(x = long, y = lat, group = group, fill = id)) + 
  geom_polygon(colour = "black") + 
  theme_void()

wahlkreise_awk <- broom::tidy(wahlkreise_map, region = "AWK") %>% 
  mutate(bez = str_trunc(id, 2, "right",""))
wahlkreise_awk %>% 
  ggplot(aes(x = long, y = lat, group = group, fill = bez)) + 
  geom_polygon(colour = "black") + 
  theme_void()

wahlkreise_awk %>% filter(bez == "05") %>% 
  ggplot(aes(x = long, y = lat, group = group, fill = id)) + 
  geom_polygon(colour = "black") + 
  theme_void()


# wahllokale_map <- readOGR(dsn = "RBS_OD_Wahllokale_AH23/RBS_OD_Wahllokale_AH23.shp", stringsAsFactors = F)
# summary(wahllokale_map)
# plot(wahllokale_map)
# wahllokale_map %>% 
#   ggplot(aes(x = long, y = lat, group = group)) + 
#   geom_polygon(colour = "black", fill = NA) + 
#   theme_void()
# ist ein Punkt-Datensatz