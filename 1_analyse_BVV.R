library(tidyverse)
source("0_read_berlin_wahldaten.R")

# data tidying
# what info do I need for Spandau BVV?
# Adresse scheint die Wahllokalnummer zu sein
# Stimmart ist trivial
# Bezirksnummer und Bezirksname sind redundant
# Wahlbezirk geht in Spandau von 1 bis 5 und ist durchnummeriert
# Wahlbezirksart ist unterteilt in Briefwahlbezirk und Urnenwahlbezirk
# bei 21 und 23 kommt noch Briefwahlbezirk dazu
# Abgeordnetenhaus- und Bundeswahlkreis jeweils "Heimatwahlkreis" der DKs
# Berlin Ost-West ist trivial in Spandau, aber natürlich spannend berlinweit
# wahlberechtigte insgesamt klar, scheint nochmal in A1,A2 (und ganz selten A3) unterteilt zu sein?
# Wähler (aktive), Wähler B1 (davon per Brief?), sowie davon gültig/ungültig

BVV21 %>% filter(Bezirksname == "Spandau") %>% pull(Briefwahlbezirk) %>% table()

names(BVV16)
(namelist16 <- names(BVV16)[c(18:27,37,66)])

names(BVV21)
(namelist21 <- names(BVV21)[c(19:29,31,33,45,48)])

names(BVV23)[44] <- "WsB Spandau"
names(BVV23)[47] <- "WisS"
names(BVV23)
(namelist23 <- names(BVV23)[c(19:29,31,32,44,47)])

for (name in names(BVV23)[1:10]){
  print(name)
  print(BVV23) %>% pull(name) %>% table() %>% print()
}

BVV23 %>% filter(Bezirksname == "Spandau") %>% pull("GRÜNE") %>% summary()
BVV23 %>% filter(Bezirksname == "Spandau") %>% pull("Gültige Stimmen") %>% summary()
