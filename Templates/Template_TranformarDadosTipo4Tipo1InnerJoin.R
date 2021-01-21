library(readxl)

# Importando dados
dados <- read_xlsx("D:/Projetos_em_R/ETL/Dados/01_Utilizacao_da_Internet.xlsx",
                  "Tabela 1.1.28.1 e 1.1.28.3 ", skip = 4, n_max=42)
tail(dados)
dados

# Particionando os dados
dados_1 <- dados[, 1:8]
names(dados_1) <- c("Local", "Total", "< 4", "4 a 7", "8 a 10", "11 a 14",
                    " > 15", "nao identificado")
dados_1

dados_2 <- dados[, 9:16]
names(dados_2) <- c("Local", "Percentual", "< 4", "4 a 7", "8 a 10", "11 a 14",
                    " > 15", "nao identificado")
dados_2

# Juncao de dados
library(tidyr)
library(magrittr)

a <- dados_1 %>% gather("< 4", "4 a 7", "8 a 10", "11 a 14",
                        " > 15", "nao identificado", key = "Anos de Estudo",
                        value = "Quantidade")

b <- dados_2 %>% gather("< 4", "4 a 7", "8 a 10", "11 a 14",
                        " > 15", "nao identificado", key = "Anos de Estudo",
                        value = "Porcentagem")
b <- b[,c(1,3,4)]

# Join das particoes
library(dplyr)
dados_final <- left_join(a, b)
view(dados_final)
