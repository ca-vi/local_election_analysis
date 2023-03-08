library(tidyverse)
source("0_read_berlin_wahldaten.R")
source("election_functions.R")

#preprocess
bind_rows(BVV23 %>% summarize_across_wahlkreise(),
          BVV21 %>% summarize_across_wahlkreise(),
          BVV16 %>% summarize_across_wahlkreise(), 
          .id = "Jahr") %>% 
  mutate(Jahr = case_when(Jahr == "1" ~ 2016, 
                          Jahr == "2" ~ 2021, 
                          Jahr == "3" ~ 2023)) -> BVV

# Parteien
parteiliste <- unique(c(names(BVV16)[c(18:27,37,66)],
                        names(BVV21)[c(19:29,31,33,45,48)],
                        names(BVV23)[c(19:29,31,32,44,47)]))

# was will ich? (purpose)
# absolute und relative stimmen. Meine Hypothese ist, dass extrem viel Potenzial
# liegen geblieben ist. Wir sollten nicht auf relative Mehrheiten schauen, 
# sondern höher zielen.
# außerdem wahlbeteiligung sehr niedrig
# außerdem strukturdaten nicht hilfreich?

# histogram Wahlbeteiligung 
BVV %>% mutate(Wahlbeteiligung = Wählende/wahlberechtigt) %>% 
  ggplot(aes(x = Wahlbeteiligung)) + 
  geom_histogram() + facet_grid(~Jahr)

# barplot Wahlbeteiligung 
BVV %>% mutate(Wahlbeteiligung = Wählende/wahlberechtigt) %>% 
  filter(Bezirk == "Spandau") %>% 
  ggplot(aes(y = Wahlbeteiligung, x = as_factor(AH_Wahlkreis))) + 
  geom_bar(aes(fill = as_factor(Jahr)), stat = "identity", position = "dodge") + 
  scale_fill_discrete("") + labs(x = "Wahlkreis")

BVV %>% mutate(Wahlbeteiligung = Wählende/wahlberechtigt) %>% 
  # filter(Bezirk == "Spandau") %>%
  ggplot(aes(x = Jahr, y = Wahlbeteiligung, color = as_factor(AH_Wahlkreis))) + 
  geom_line() + scale_color_discrete("") + facet_wrap(~Bezirk)

# Hypothese: Grünes Ergebnis korreliert mit der Wahlbeteiligung
# Erklärung: höhere wahlbeteiligung vor allem bei jungen Menschen --> Grün
# während ältere Menschen "regelmäßiger" wählen gehen --> Schwarz

BVV23 %>% filter(Bezirksname == "Spandau") %>% pull("GRÜNE") %>% summary()
BVV23 %>% filter(Bezirksname == "Spandau") %>% pull("Gültige Stimmen") %>% summary()
