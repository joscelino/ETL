library(tibble)
library(dplyr)

# Data frames
# Salarios
salarios <- as_tibble(Lahman::Salaries)
glimpse(salarios)

# Master
master <- as_tibble(Lahman::Master)

# Associacao entre cadastro e salarios
names(master)

base <- left_join(salarios, master, by = "playerID")
base

# Selecionando as variaveis
base <- base %>% select(yearID, teamID, playerID, nameGiven, birthCountry, salary)

dadosFinais <- base[order(base$salary, decreasing = TRUE),]

