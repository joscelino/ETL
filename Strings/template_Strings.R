library(pacman)
pacman::p_load(stringr, tibble, dplyr)
# Detectando padroes de strings
x <- c("San Diego", "Los Angeles", "Chicago", "Washington", "Houston")

# Contando ocorrencias
str_detect(x, "a")
sum(str_count(x, "a"))
str_detect(x, "[aA]")
sum(str_count(x, "[aA]"))

# Detectando padroes (Begins with)
str_starts(x,"Chi")

# Detectando padroes (ends)
str_ends(x,"o")

# Vetor a partir de banco de palavras da propria biblioteca
palavras <- words
sum(str_starts(palavras,"w"))
sum(str_ends(palavras,"d"))

# Mostrando palavras que comecam com determinada letra
palavras[str_starts(palavras,"w")]

# Mostrando palavras que terminam com determinada letra
palavras[str_ends(palavras,"d")]
str_subset(palavras,"d$")

# Mostrando palavras com uma OU outra letra
str_detect(palavras,"[aei]")
palavras[str_detect(palavras,"[xy]")]
str_subset(palavras,"[jq]")

# Mostrando padroes que NAO correspondem a um padrao
palavras[!str_detect(palavras,"[jqlmyzaoei]")]

# Efetuando busca de palavras em dataframe tibble

# Criando o dataframe
dados <- tibble(
  word=words,
  i=seq_along(words)
)


dados$i <- as.factor(dados$i)
dados

# Palavras que terminam com um padrao
dados %>% filter(str_ends(word, "y"))

# Palavras que iniciam com um padrao
dados %>% filter(str_starts(word, "y"))

# Palavras que NAO possuem um determinado padrao
dados %>% filter(!str_detect(word,"[jqlmyzaoei]"))

# Criando novas variaveis
dados %>% mutate(vogais=str_count(word,"[aeiou]"),
                 consoantes=str_count(word,"[^aeiou]"))

# Extraindo correspondencias
sentencas <- stringr::sentences
head(sentencas)
tail(sentencas)
length(sentencas) 

cores <- c(" blue", " orange", " black", " green", " yellow", " purple", " red",
           " white")
cores

cores2 <- str_c(cores, collapse = "|")
cores2

# Buscando frases com os padroes
frases <- str_subset(sentencas,cores2)

# Extraindo os padroes das frases
str_extract(frases,cores2) # Extrai apenas a primeira correspondencia
str_extract_all(frases,cores2) # Extrai todas as correspondencias

frasesSelecionadas <- sentencas[str_count(sentencas,cores2)>1]

# Visualizando as ocorrencias com destaque
str_view_all(frasesSelecionadas, cores2)

# Splitting de textos

# Substituindo correspondencias
x <- c("apple","pear","banana","inconstitucional")
str_replace_all(x,"[aeiou]","_")

y <- c("1 casa","2 carros sao 2 veiculos","3 pessoas")
str_replace_all(y,c("1"="uma", "2"="dois", "3"="tres"))


# Splitting de sentencas
sentencas %>% head(2) %>% str_split(" ")
head(str_split(sentencas, simplify = TRUE, boundary("word")))

s <- "Primeira sentenca. Outra sentenca."
head(str_split(s, simplify = TRUE, boundary("sentence")))

# Procurando padroes - pontos especiais
frutas <- stringr::fruit
str_view(frutas, "nana")
str_view(frutas, "ple")

bananas <- c("Banana", "banana", "BANANA")
str_view(bananas, "nana")
str_view(bananas, regex("nana", ignore_case = TRUE))
