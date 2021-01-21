library(tibble)

# Importando dados
plan <- read_xlsx("D:/Projetos_em_R/ETL/Dados/Meusdados.xlsx", "tipo2")
plan

# Separando as variaveis de obitos
plan_ajustada <- spread(plan, key = "tipo", value = "count")
