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

polish_data_names <- function(data) {
  data %>% 
    select(c("Bezirk" = "Bezirksname", "AH_Wahlkreis" = matches("^Abgeordneten.*hauswahlkreis")) | 
             any_of(c("wahlberechtigt" = "Wahlberechtigte insgesamt", "Wählende" = matches("^Wähle(r|nde)$"),
             "gültig" = "Gültige Stimmen", "ungültig" = "Ungültige Stimmen")) | 
             matches("(SPD|Einwohner Anzahl)"):last_col()) %>% 
    mutate(across(-1, as.numeric)) %>% 
    return()
}

summarize_across_ah_wahlkreise <- function(data) {
  data %>% polish_data_names() %>% 
    group_by(Bezirk, AH_Wahlkreis) %>% 
    summarize(across(everything(), sum)) %>% 
    return() # still grouped by Bezirk
}