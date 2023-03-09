struktur <- readxl::read_excel("DL_BE_AGH2023_Strukturdaten.xlsx", sheet = "Strukturdaten")
# struktur %>% glimpse() 

# BVV21 %>% filter(Wahlbezirksart == "W") %>% dim()
# AGH23_zweitstimme %>% filter(Wahlbezirksart == "W") %>% dim()
# es gab 2021+2023 2257 "Adressen" von Wahllokalen
# aber 2016 nur 1779
# d.h. strukturdaten nur 2021/23 anwendbar
# bei der analyse wahldaten mit strukturdaten müssen die Briefwahlstimmen
# irgendwie alloziert werden...
# ich könnte auch eine ebene höher gehen und auf Briefwahlkreise aggregieren
# ich könnte auch noch eine ebene höher auf ah-wahlkreise aggregrieren
# aber da verliere ich natürlich Schärfe in den Daten
