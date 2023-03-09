library(tidyverse)
source("0_read_berlin_strukturdaten.R")
source("0_read_berlin_wahldaten.R")
source("election_functions.R")

BVV <- get_BVV_ah() %>% mutate(GRÜNE_p = GRÜNE / Wählende)
struktur <- get_struktur() %>% summarize_across_ah_wahlkreise()

BVV_struktur <- right_join(BVV %>% filter(Jahr == 2023), struktur, by = c("Bezirk", "AH_Wahlkreis"))

#alter
# Rentner
ggplot(BVV_struktur, aes(x = `Einwohner 65 und älter Prozent`, y = GRÜNE_p)) + 
  geom_point() + geom_smooth(method = "lm")
  # aes(shape = Bezirk) + scale_shape_manual(values = c(1:10,12,13))
# Boomer
ggplot(BVV_struktur, aes(x = `Deutsche 45 - 60 Anzahl`, y = GRÜNE_p)) + 
  geom_point() + geom_smooth(method = "lm")
# GenX
ggplot(BVV_struktur, aes(x = `Deutsche 35 - 45 Anzahl`, y = GRÜNE_p)) + 
  geom_point() + geom_smooth(method = "lm")
# GenY/Millenlials
ggplot(BVV_struktur, aes(x = `Deutsche 25 - 35 Anzahl`, y = GRÜNE_p)) + 
  geom_point() + geom_smooth(method = "lm")
# GenZ
ggplot(BVV_struktur, aes(x = `Deutsche 18 - 25 Anzahl`, y = GRÜNE_p)) + 
  geom_point() + geom_smooth(method = "lm")

# ausländer/eu/migration
ggplot(BVV_struktur, aes(x = `Ausländer Prozent`, y = GRÜNE_p)) + 
  geom_point() + geom_smooth(method = "lm")
ggplot(BVV_struktur, aes(x = `Deutsche 16 + Migrationshintergrund Prozent`, y = GRÜNE_p)) + 
  geom_point() + geom_smooth(method = "lm")

# LGTBQ
ggplot(BVV_struktur, aes(x = `Deutsche 18 + Familienstand ELP Prozent`, y = GRÜNE_p)) + 
  geom_point() + geom_smooth(method = "lm")

# Arbeitslosenquote (in SGB2)
ggplot(BVV_struktur, aes(x = `Einwohner unter 65 in SGB II 2021 Prozent`, y = GRÜNE_p)) + 
  geom_point() + geom_smooth(method = "lm")
