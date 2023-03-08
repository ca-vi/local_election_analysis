library(tidyverse)
source("0_read_berlin_wahldaten.R")
source("election_functions.R")

# preprocess
#####
# Parteien 
parteiliste <- unique(c(names(BVV16)[c(18:27,37,66)],
                        names(BVV21)[c(19:29,31,33,45,48)],
                        names(BVV23)[c(19:29,31,32,44,47)]))
bind_rows(BVV23 %>% summarize_across_wahlkreise(),
          BVV21 %>% summarize_across_wahlkreise(),
          BVV16 %>% summarize_across_wahlkreise(), 
          .id = "Jahr") %>% 
  mutate(Jahr = case_when(Jahr == "1" ~ 2016, 
                          Jahr == "2" ~ 2021, 
                          Jahr == "3" ~ 2023)) %>% 
  select(Jahr:ungültig | any_of(parteiliste)) -> BVV

# was will ich? (purpose)
# Wahlbeteiligung anschauen, Stimmen anschauen, Zeitverlauf jeweils
# nur auf relative Prozentpunkte zu schauen ist zu klein gedacht
# Strukturdaten zeigen bevölkerungssituation in spandau nicht hilfreich?

#####
# Wahlbeteiligung
#####
# histogram Wahlbeteiligung Berlin
BVV %>% mutate(Wahlbeteiligung = Wählende/wahlberechtigt) %>% 
  ggplot(aes(x = Wahlbeteiligung)) + 
  geom_histogram() + facet_grid(~Jahr)

# barplot Wahlbeteiligung Spandau
BVV %>% mutate(Wahlbeteiligung = Wählende/wahlberechtigt) %>% 
  filter(Bezirk == "Spandau") %>% 
  ggplot(aes(y = Wahlbeteiligung, x = as_factor(AH_Wahlkreis))) + 
  geom_bar(aes(fill = as_factor(Jahr)), stat = "identity", position = "dodge") + 
  scale_fill_discrete("") + labs(x = "Wahlkreis")

# lineplot Wahlbeteiligung Vergleich Berlin
BVV %>% mutate(Wahlbeteiligung = Wählende/wahlberechtigt) %>% 
  # filter(Bezirk == "Spandau") %>%
  ggplot(aes(x = Jahr, y = Wahlbeteiligung, color = as_factor(AH_Wahlkreis))) + 
  geom_line() + scale_color_discrete("") + facet_wrap(~Bezirk)

#####
# Stimmen
#####
# absolute Stimmenanzahl
# lineplot
BVV %>% 
  ggplot(aes(x = Jahr, y = GRÜNE, color = as_factor(AH_Wahlkreis))) + 
  geom_line() + scale_color_discrete("") + facet_wrap(~Bezirk)
# relativer Stimmenanteil
# lineplot
BVV %>% mutate(across(SPD:ÖDP, function(c){c/Wählende})) %>% 
  ggplot(aes(x = Jahr, y = GRÜNE, color = as_factor(AH_Wahlkreis))) + 
  geom_line() + scale_color_discrete("") + facet_wrap(~Bezirk)
# lineplot für Spandau
BVV %>% mutate(across(SPD:ÖDP, function(c){c/Wählende})) %>% 
  filter(Bezirk == "Spandau") %>% 
  ggplot(aes(x = Jahr, y = GRÜNE, color = as_factor(AH_Wahlkreis))) + 
  geom_line() + scale_color_discrete("")

# es tun sich drei Fragen auf: 1. was macht einen Wahlkreis aus, damit ein hoher 
# Anteil Grünenwähler vorkommt? Entfernung zur City, Strukturdaten
# 2. Was macht einen Wahlkreis aus, sodass er viele Stimmen verloren hat? Alter?
# 3. Korreliert Stimmenverlauf, Wahlbeteiligungsverlauf?
# Hypothese: Grünes Ergebnis korreliert mit der Wahlbeteiligung
# Erklärung: höhere wahlbeteiligung vor allem bei jungen Menschen --> Grün
# während ältere Menschen "regelmäßiger" wählen gehen --> Schwarz

BVV %>% mutate(Wahlbeteiligung = Wählende/wahlberechtigt) %>% 
  ungroup() %>% 
  select(Wahlbeteiligung, SPD:GRÜNE) %>% 
  # summarize_all(class)
  cor()

# vllt ist ein vergleichbarer wahlkreis (Hartz4, Alter, Ausländer) in anderen
# Bezirken besser. Da ist also Potenzial und wir könnten gezielter Wahlkampf machen