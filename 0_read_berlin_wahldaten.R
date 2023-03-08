
AGH23_erststimme  <- readxl::read_excel("DL_BE_AGHBVV2023.xlsx", sheet = "AGH_W1")
AGH23_zweitstimme <- readxl::read_excel("DL_BE_AGHBVV2023.xlsx", sheet = "AGH_W2")
BVV23             <- readxl::read_excel("DL_BE_AGHBVV2023.xlsx", sheet = "BVV")

AGH21_erststimme  <- readxl::read_excel("DL_BE_AGHBVV2021.xlsx", sheet = "AGH_W1")
AGH21_zweitstimme <- readxl::read_excel("DL_BE_AGHBVV2021.xlsx", sheet = "AGH_W2")
BVV21             <- readxl::read_excel("DL_BE_AGHBVV2021.xlsx", sheet = "BVV")

AGH16_erststimme  <- readxl::read_excel("DL_BE_EE_WB_AH2016.xlsx", sheet = "Erststimme")
AGH16_zweitstimme <- readxl::read_excel("DL_BE_EE_WB_AH2016.xlsx", sheet = "Zweitstimme")
BVV16             <- readxl::read_excel("DL_BE_EE_WB_AH2016.xlsx", sheet = "BVV")

BVV16[,7] <- AGH16_zweitstimme[,7]
names(BVV23)[names(BVV23) == "WB WsB Spandau"] <- "WsB Spandau"
names(BVV23)[names(BVV23) == "WB WisS"] <- "WisS"
