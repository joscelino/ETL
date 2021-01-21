library(tibble)
library(readxl)

# Importando dados
plan <- read_xlsx("D:/Projetos_em_R/ETL/Dados/Meusdados.xlsx", "tipo4", 
                  skip = 1, n_max=6)
plan

# Renomendo os titulos das colunas
names(plan)[1] <- c("Regioes")
names(plan)[2:11] <- rep(2005:2009, 2)

# Separando os obitos
tab4_ObitosFetais <- plan[,1:6]
tab4_ObitosFetais
tab4_ObitosTotais <- plan[,c(1, 7:11)]
tab4_ObitosTotais

library(tidyr)
library(magrittr)


a <- tab4_ObitosFetais %>% gather("2005", "2006", "2007", "2008", "2009", 
                                  key = "Ano", value = "Obitos Fetais")

b <- tab4_ObitosTotais %>% gather("2005", "2006", "2007", "2008", "2009", 
                                  key = "Ano", value = "Obitos")
# Juntando as tabelas
tabObitos <- cbind(a, b)
tabObitos <- tabObitos[,-(4:5)]
tabObitos

# Tranformando data frame em tibble
tabObitos <- as_tibble(tabObitos)
