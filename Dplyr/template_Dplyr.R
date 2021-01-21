library(pacman)
pacman::p_load(readr, tidyverse)

dados <- read_csv("D:/Projetos_em_R/Diversos/Dados/venda_games.csv")
dados$Rank <- base::factor(base::order(dados$Rank))
dados$Name <- base::factor(dados$Name)
dados$Platform <- base::factor(dados$Platform)
dados$Year  <- base::factor(dados$Year)
dados$Genre <- base::factor(dados$Genre)
dados$Publisher <- base::factor(dados$Publisher)
dados

# Selecionando dados
# Selecionando dados por atributos
dados %>% dplyr::select(Year,Rank,Platform)


dados %>% dplyr::select(dplyr::contains("form"),
                        dplyr::starts_with("Ra"),
                        dplyr::contains("Sales"),
                        dplyr::ends_with("ar"))

# Selecionando dados por sequencia especifica 
dados %>% dplyr::select(Platform, Genre, dplyr::everything())

# Usando a negacao de atributos
dados %>% dplyr::select(Year,-Rank,Platform)
dados %>% dplyr::select(dplyr::contains("form"),
                        -dplyr::starts_with("Ra"),
                        dplyr::contains("Sales"),
                        -dplyr::ends_with("ar"))

# Filtar dados
dados %>% dplyr::filter(Rank == 100)
dados %>% dplyr::filter(Global_Sales < 20)
dados %>% dplyr::filter(Platform == 'NES')
dados %>% dplyr::filter(Publisher == 'Nintendo')p

# Operadores em filtros
dados %>% dplyr::filter(Platform == 'X360' & Genre == 'Action') 
dados %>% dplyr::filter(Platform == 'NES' | Global_Sales < 20)
dados %>% dplyr::filter(Global_Sales > 10 & Global_Sales < 20)
dados %>% dplyr::filter(base::as.character(Year)>2010 & Global_Sales<20)
dados %>% dplyr::filter(Genre %in% c("Sports", "Plataform", "Action"))
dados %>% dplyr::filter(Genre %in% c("Sports", "Plataform", "Action"),
                        base::as.character(Year) > 2010, Publisher == "Nintendo",
                        Global_Sales < 20,Platform == '3DS')

# Utilizando Filter e Select Juntos e remover duplicatas
dados %>% dplyr::filter(Genre %in% c("Sports", "Plataform", "Action"),
                        base::as.character(Year) > 2010, Publisher == "Nintendo",
                        Global_Sales < 20,Platform == '3DS') %>%
  dplyr::select(Platform, Genre, dplyr::everything()) %>% dplyr::distinct()

dados %>% dplyr::filter(base::as.character(Year) < 1985) %>%
  dplyr::select(Genre,Year) %>% dplyr::distinct()

dados %>% dplyr::filter(Genre %in% c("Sports", "Plataform", "Action")) %>%
  dplyr::select(Platform,dplyr::ends_with("ales")) %>% dplyr::distinct()

# Classificando dados
dados %>% dplyr::filter(Publisher == "Nintendo" | Genre %in%
                          c("Sports", "Plataform", "Action")) %>% 
  dplyr::select(Rank,Name,Genre)  %>% dplyr::arrange(desc(Rank)) %>% 
  dplyr::distinct()

# RENOMEANDO atributos
dados %>% dplyr::filter(base::as.character(Year) == 2005, 
                        Platform == 'PSP') %>%
  dplyr::select(Genre, Publisher, Rank) %>% dplyr::distinct() %>%
  dplyr::rename(Genero = Genre, Posicao = Rank)

# CRIANDO ATRIBUTOS
dados2 <- dados %>% dplyr::filter(base::as.character(Year) == 2005, 
                                  Platform == 'PSP') %>%
  dplyr::select(Genre, Publisher, Rank, dplyr::everything(),-Platform) %>% 
  dplyr::distinct()

dados2 <- dados2 %>% dplyr::mutate(perc_other = Other_Sales/Global_Sales*100,
                                   Publisher = base::toupper(Publisher),
                                   Div2 = base::as.numeric(Rank) %% 2 == 0)
glimpse(dados2)

# AGRUPAMENTO de conjunto de dados
dados %>% dplyr::count(Year)
dados %>% dplyr::count(Year, Platform) %>% dplyr::rename(contador = n)

dados %>% dplyr::filter(base::as.character(Year) == "1985") %>% 
  dplyr::select(Platform)
dados %>% dplyr::filter(base::as.character(Year) == "1985") %>% 
  dplyr::select(Year, Platform) %>% dplyr::group_by(Year) %>%
  dplyr::summarise(contador = n())
dados %>% dplyr::filter(base::as.character(Year) == "1985") %>% 
  dplyr::select(Year, Platform) %>% dplyr::group_by(Year) %>%
  dplyr::summarise(contador = n_distinct(Platform))

dados %>% dplyr::group_by(Year, Platform, Genre) %>% summarise(contador = n())

# SOMA DE ATRIBUTOS AGRUPADOS
dados %>% dplyr::group_by(Year) %>% dplyr::summarise(sum(Global_Sales))

# Soma
dados %>% dplyr::group_by(Platform) %>% 
  dplyr::summarise(soma = base::sum(Global_Sales), 
                   media = base::mean(Global_Sales),
                   maximo = base::max(Global_Sales),
                   minimo = base::min(Global_Sales),
                   desvio = stats::sd(Global_Sales),
                   quantidade = dplyr::n()) %>% dplyr::arrange(desc(soma))

