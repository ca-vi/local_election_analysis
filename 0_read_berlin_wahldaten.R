
get_AGH23_erststimme  <- function() readxl::read_excel("DL_BE_AGHBVV2023.xlsx", sheet = "AGH_W1")
get_AGH23_zweitstimme <- function() readxl::read_excel("DL_BE_AGHBVV2023.xlsx", sheet = "AGH_W2")
get_BVV23             <- function() { 
  df <- readxl::read_excel("DL_BE_AGHBVV2023.xlsx", sheet = "BVV")
  names(df)[names(df) == "WB WsB Spandau"] <- "WsB Spandau"
  names(df)[names(df) == "WB WisS"] <- "WisS"
  return(df)
}

get_AGH21_erststimme  <- function() readxl::read_excel("DL_BE_AGHBVV2021.xlsx", sheet = "AGH_W1")
get_AGH21_zweitstimme <- function() readxl::read_excel("DL_BE_AGHBVV2021.xlsx", sheet = "AGH_W2")
get_BVV21             <- function() readxl::read_excel("DL_BE_AGHBVV2021.xlsx", sheet = "BVV")

get_AGH16_erststimme  <- function() readxl::read_excel("DL_BE_EE_WB_AH2016.xlsx", sheet = "Erststimme")
get_AGH16_zweitstimme <- function() readxl::read_excel("DL_BE_EE_WB_AH2016.xlsx", sheet = "Zweitstimme")
get_BVV16             <- function() {
  df <- readxl::read_excel("DL_BE_EE_WB_AH2016.xlsx", sheet = "BVV")
  df[,7] <- get_AGH16_zweitstimme()[,7]
  return(df)
}
