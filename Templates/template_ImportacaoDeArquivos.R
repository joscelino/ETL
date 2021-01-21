library(tibble)

# Importando txt separado por espacos em branco
cap1 <- read.table("D:/Projetos_em_R/ETL/Dados/caprinosEspeçoBranco.txt", 
                   sep = "", header = TRUE)
cap1 <- as_tibble(cap1)
cap1

# Importando txt separado por TAB
cap2 <- read.table("D:/Projetos_em_R/ETL/Dados/caprinosTAB.txt", sep = "\t", 
                   header = TRUE)
cap2 <- as_tibble(cap2)
cap2

# Importando txt separado por outros separadores
# Separador 
cap3 <- read.table("D:/Projetos_em_R/ETL/Dados/caprinosPontoeVirgula.txt", 
                   sep = ";", header = TRUE)
cap3 <- as_tibble(cap3)
cap3

# Qualquer &
cap4 <- read.table("D:/Projetos_em_R/ETL/Dados/caprinosOutrosSeparadores.txt", 
                   sep = "&", header = TRUE)
cap4 <- as_tibble(cap4)
cap4

# Pulando linhas ao importar um txt 
# Atributo "Skip" para setar o numero de linhas a serem puladas
cap5 <- read.table("D:/Projetos_em_R/ETL/Dados/caprinosTABeTexto.txt", 
                   sep = "\t", header = TRUE, skip = 6)
cap5 <- as_tibble(cap5)
cap5

# Lendo textos
text <- readLines("D:/Projetos_em_R/ETL/Dados/texto.txt")
text

# Lendo pagina internet
net <- read.table("https://docs.ufpr.br/~giolo/CE073/Dados/coronaria.txt",
                  sep = "", header = TRUE)


net <- as_tibble(net)
net

# Importando com melhor performance
library(readr)

# Importando txt separado por espacos em branco
cap11 <- read_table2("D:/Projetos_em_R/ETL/Dados/caprinosEspeçoBranco.txt",
                     col_names = TRUE)
cap11

# Importando txt separado por TAB
cap21 <- read_table2("D:/Projetos_em_R/ETL/Dados/caprinosTAB.txt", 
                     col_names = TRUE)
cap21

# Importando arquivos com texto antes dos dados
cap51 <- read_table2("D:/Projetos_em_R/ETL/Dados/caprinosTABeTexto.txt", 
                     skip = 6, col_names = TRUE)
cap51

# Importando CSV separado por virgula
csv <- read_csv2("D:/Projetos_em_R/ETL/Dados/caprinosCSV_virgula.csv",
                 col_names = TRUE)
csv

# Importando planilha xlsx
# Importar manualmente ate correcao da biblioteca xlsx
library(readxl)
plan <- read_excel("D:/Projetos_em_R/ETL/Dados/caprinosXLSX.xlsx", sheet = 1)
plan <- as_tibble(plan)
plan

# Importando codigo fonte
html <- url("https://www.mql5.com/")
codigo <- readLines(html)
head(codigo)

# Forma geral de importacao de arquivos
dados <- file.choose()

### Bancos de dados
## Pacotes: RMySQL, RPostgreSQL, xml2, jsonlite