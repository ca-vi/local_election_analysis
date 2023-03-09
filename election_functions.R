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

# preprocess
#####
# data tidying
# what info do I need?
polish_data_names <- function(data) {
  data %>%
    select(c("Bezirk" = "Bezirksname", "AH_Wahlkreis" = matches("^Abgeordneten.*hauswahlkreis")) | 
             any_of(c("Wählende" = matches("^Wähle(r|nde)$"))) |
             any_of(c("wahlberechtigt" = "Wahlberechtigte insgesamt", 
                      "gültig" = "Gültige Stimmen", "ungültig" = "Ungültige Stimmen")) | 
             matches("(SPD|Einwohner Anzahl)"):last_col()) %>%
    # works with wahl und struktur
    mutate(across(-1, as.numeric)) %>% 
    return()
}

summarize_across_ah_wahlkreise <- function(data) {
  data %>% polish_data_names() %>% 
    group_by(Bezirk, AH_Wahlkreis) %>% 
    summarize(across(everything() & !matches("Prozent"), sum), 
              across(matches("Prozent"), mean)) %>% 
    return() # still grouped by Bezirk
}

get_BVV_ah <- function() {
  BVV23 <- get_BVV23()
  BVV21 <- get_BVV21()
  BVV16 <- get_BVV16()
  parteiliste <- unique(c(names(BVV16)[c(18:27,37,66)],
                          names(BVV21)[c(19:29,31,33,45,48)],
                          names(BVV23)[c(19:29,31,32,44,47)]))
  # das sind die Parteien, die in Spandau mindestens eine Stimme haben
  bind_rows(BVV23 %>% summarize_across_ah_wahlkreise(),
            BVV21 %>% summarize_across_ah_wahlkreise(),
            BVV16 %>% summarize_across_ah_wahlkreise(), 
            .id = "Jahr") %>% 
    mutate(Jahr = case_when(Jahr == "1" ~ 2016, 
                            Jahr == "2" ~ 2021, 
                            Jahr == "3" ~ 2023)) %>% 
    select(Jahr:ungültig | any_of(parteiliste)) %>% 
    return()
}  
