library(pacman)
pacman::p_load(readr, tidyverse)

dados <- read_csv("D:/Projetos_em_R/Diversos/Dados/venda_games.csv")
dados$Rank <- base::factor(base::order(dados$Rank))
dados$Name <- base::factor(dados$Name)
dados$Platform <- base::factor(dados$Platform)
dados$Year  <- base::factor(dados$Year)
dados$Genre <- base::factor(dados$Genre)
dados$Publisher <- base::factor(dados$Publisher)

#DATASET DE JOGOS DE ACAO
dadosAcao <- dados %>% dplyr::filter(Genre %in% c("Sports", "Action")) %>%
  dplyr::select(Name, Platform, Year, Genre, dplyr::ends_with("Sales")) %>%
  dplyr::distinct()

# DATASET JOGOS ROLETA E PUZZLE
dadosPuzzle <- dados %>% dplyr::filter(Genre %in% c("Role-Playing", 
                                                    "Puzzle")) %>%
  dplyr::select(Name, Year, Genre, EU_Sales) %>% dplyr::distinct()

# INNER-JOIN
dadosResultantes <- dplyr::inner_join(dadosAcao,dadosPuzzle)

dadosInner <- dplyr::inner_join(dadosAcao,dadosPuzzle,
                                by = c("Year" = "Year"),
                                suffix = c("_1", "_2")) %>%
  dplyr::select(Name_1,Platform,Genre_1,Genre_2)

dadosInner2 <- dplyr::inner_join(dadosAcao,dadosPuzzle,
                                 by = c("Year" = "Year"),
                                 suffix = c("_1", "_2")) %>%
  dplyr::select(Name_1,Platform,Genre_1,Genre_2)

# ANTI-JOIN
dadosAnti <- dplyr::anti_join(dadosAcao,dadosPuzzle,
                              by = c("Year" = "Year"))

# LEFT-JOIN e RIGHT-JOIN
dadosPuzzleAno <- dadosPuzzle %>% dplyr::filter(base::as.character(Year) %in%
                                                  c(2017, 2016, 2015)) %>% 
  dplyr::distinct()

dadosAcaoAno <- dadosAcao %>% dplyr::filter(base::as.character(Year) %in%
                                                  c(2017, 2014, 2015, 2012)) %>% 
  dplyr::distinct()

dadosLeft <- dplyr::left_join(dadosAcaoAno,dadosPuzzleAno,
                              by = c("Year" =  "Year"),
                              suffix = c("_1", "_2"))

dadosLeft %>% dplyr::filter(base::as.character(Year) == 2014)

dadosRight <- dplyr::right_join(dadosAcaoAno,dadosPuzzleAno,
                              by = c("Year" =  "Year"),
                              suffix = c("_1", "_2"))

dadosRight %>% dplyr::filter(base::as.character(Year) == 2016)

# FULL-JOIN
dadosFull <- dplyr::full_join(dadosAcao,dadosPuzzleAno)
dadosFull %>% dplyr::filter(base::as.character(Year) == 2016)
