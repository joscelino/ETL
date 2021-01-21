library(tibble)
library(readxl)

# Importando dados
plan <- read_xlsx("D:/Projetos_em_R/ETL/Dados/Meusdados.xlsx", "tipo3")
names(plan)[3] <- c("taxa")
plan

# Separando as variaveis de obitos
library(magrittr)
plan_ajustada <- plan %>% separate(taxa, into = c("Obitos Fetais", "Obitos"),
                                   convert = TRUE, sep = "/")
plan_ajustada

# Separando o ano
plan_ajustada <- plan_ajustada %>% separate(Ano, into = c("Seculo", "ano"),
                                            sep = -2)
plan_ajustada

# Juntando dados separados
plan_ajustada <- plan_ajustada %>% unite(col = Ano, Seculo, ano, sep = "")
plan_ajustada
