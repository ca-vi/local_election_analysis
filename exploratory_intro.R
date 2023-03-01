library(tidyverse)
source("0_read_berlin_wahldaten.R")

glimpse(BVV)
names(BVV16)
table(BVV$Bezirksname)

BVV %>% filter(Bezirksname == "Spandau") %>% pull("GRÜNE") %>% summary()
BVV %>% filter(Bezirksname == "Spandau") %>% pull("Gültige Stimmen") %>% summary()
