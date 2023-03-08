check_metadata <- function(wahldaten) {
  names(wahldaten) %>% print()
  for (name in names(wahldaten)[1:18]) {
    print(name)
    wahldaten %>% pull(name) -> data
    if (length(names(table(data))) > 12) {
      print(class(data))
      print(summary(data))
      print(head(data, n = 12))
    } else {
      print(class(data))
      print(table(data))
    }
  }
}

# data tidying
# what info do I need for Spandau BVV?
# Adresse scheint die Wahllokalnummer zu sein
# Stimmart ist trivial
# Bezirksnummer und Bezirksname sind redundant
# Wahlbezirk geht in Spandau von 1 bis 5 und ist durchnummeriert
# Wahlbezirksart ist unterteilt in Briefwahlbezirk und Urnenwahlbezirk
# bei '21 und '23 kommt noch Briefwahlbezirk dazu
# Abgeordnetenhaus- und Bundeswahlkreis jeweils "Heimatwahlkreis" der DKs
# Berlin Ost-West ist trivial in Spandau, aber natürlich spannend berlinweit
# wahlberechtigte insgesamt klar, ist unterteilt in A1 ohne wahlschein
# A2 mit wahlschein, A3 am Wahltag einen wahlschein
# Wähler (aktive), Wähler B1 (davon per Brief?), sowie davon gültig/ungültig

# was kann weg? stimmart, bezirksnummer, ostwest, bundestagswahlkreis

polish_metadata <- function(wahldaten) {
  wahldaten %>% 
    select(c("Bezirk" = "Bezirksname", "AH_Wahlkreis" = "Abgeordneten-\r\nhauswahlkreis", 
             "wahlberechtigt" = "Wahlberechtigte insgesamt") | matches("$Wähle.*") &
             !matches(".*B1") | 
             c("gültig" = "Gültige Stimmen", "ungültig" = "Ungültige Stimmen") | 
             "SPD":last_col()) %>% 
    rename("Wählende" = 4) %>% 
    mutate(across(-1, as.numeric)) %>% 
    return()
}

summarize_across_wahlkreise <- function(wahldaten) {
  wahldaten %>% polish_metadata() %>% 
    group_by(Bezirk, AH_Wahlkreis) %>% 
    summarize(across(everything(),sum)) %>% 
    return() # still grouped by bezirk
}
