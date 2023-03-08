library(tidyverse)
source("0_read_berlin_wahldaten.R")
source("election_functions.R")

bind_rows(BVV23 %>% summarize_across_wahlkreise(),
          BVV21 %>% summarize_across_wahlkreise(),
          BVV16 %>% summarize_across_wahlkreise(), 
          .id = "year") %T>% assign(x = "BVV") %>% 
  mutate(year = case_when(year == 1 ~ 2016, 
                          year == 2 ~ 2021, 
                          year == 3 ~ 2023)) %>% 
  glimpse()

# Parteien
parteiliste <- unique(c(names(BVV16)[c(18:27,37,66)],
                        names(BVV21)[c(19:29,31,33,45,48)],
                        names(BVV23)[c(19:29,31,32,44,47)]))


# was will ich? (purpose)
# absolute und relative stimmen. Meine Hypothese ist, dass extrem viel Potenzial
# liegen geblieben ist. Wir sollten nicht auf relative Mehrheiten schauen, 
# sondern höher zielen.

#histogram wahlbeteiligung in spandau
BVV23 %>% filter(Bezirksname == "Spandau") %>% pull("Wahlberechtigte insgesamt") %>% summary()
BVV23 %>% filter(`Wahlberechtigte insgesamt` != 0) %>% mutate(wahlbeteiligung = `Wählende` / `Wahlberechtigte insgesamt`) %>%
  pull(wahlbeteiligung) %>% summary()
BVV23 %>% filter(Bezirksname == "Spandau") %>% 
  ggplot(aes(x = "Wählende")) + geom_histogram()


BVV23 %>% filter(Bezirksname == "Spandau") %>% pull("GRÜNE") %>% summary()
BVV23 %>% filter(Bezirksname == "Spandau") %>% pull("Gültige Stimmen") %>% summary()
