library(tidyverse)
source("0_read_berlin_wahldaten.R")

# data tidying
# what column do I need for Spandau?
names(BVV21)
BVV16 %>% filter(Bezirksname == "Spandau") %>% select(seq(44,69)) %>% as.matrix() %>% sum()

table(BVV23$Bezirksname)
BVV23 %>% filter(Bezirksname == "Spandau") %>% pull("GRÜNE") %>% summary()
BVV23 %>% filter(Bezirksname == "Spandau") %>% pull("Gültige Stimmen") %>% summary()
