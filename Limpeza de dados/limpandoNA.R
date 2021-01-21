library(pacman)
pacman::p_load(readxl,tibble,dplyr)

# Importando os dados
dados <- read_xlsx("D:/Projetos_em_R/ETL/Dados/dados.xlsx", sheet = "Obitos")
dados
view(dados)

# Excluindo linhas e colunas de NA
dados <- dados[-(26:27),-(5:6)]

# Ajustando os tipos de dados
dados$Regiao <- as.factor(dados$Regiao)
dados$Ano <- as.factor(dados$Ano)

# Selecionando dados
dados %>% dplyr::select(Regiao, Ano, Obitos)
dados %>% dplyr::select(Regiao, Ano, `obitos fetais`)

# Selecionar casos
dados %>% dplyr::filter(Regiao=="Norte")
dados %>% dplyr::filter(Regiao=="Sudeste")
dados %>% dplyr::filter(Ano==2005) %>% dplyr::arrange(Obitos)
dados %>% dplyr::filter(Regiao=="Sudeste" & Ano==2005)
dados %>% dplyr::filter(Regiao=="Sudeste" | Regiao=="Norte")
dados %>% dplyr::filter(Regiao=="Sudeste" | Regiao=="Norte", 
                        Obitos>60000 & `obitos fetais`<12000) %>% 
  dplyr::arrange(Ano)

dados %>% dplyr::filter(Regiao=="Sudeste" | Regiao=="Norte", 
                        Obitos>60000 & `obitos fetais`<12000) %>% 
  dplyr::arrange(desc(Ano))

# Agrupamentos por variaveis categoricas
datasusAno <- dados %>% dplyr::group_by(Ano)
datasusAno %>% dplyr::summarise(MediaObitos=mean(Obitos))
datasusAno %>% dplyr::summarise(SomaObitos=sum(Obitos))

datasusRegiao <- dados %>% dplyr::group_by(Regiao)
datasusRegiao %>% dplyr::summarise(SomaObitos=sum(`obitos fetais`),
                                   MedianaObitos=median(`obitos fetais`))

# Inserindo colunas
dados$Programa <- as.factor(dplyr::if_else(dados$`obitos fetais`<2100,"Programa A",
                                           dplyr::if_else(dados$`obitos fetais`>=2101 
                                           & dados$`obitos fetais`<5000,
                                           "Programa B", "Programa C")))
dados

# Particionando
datasusPrograma <- dados %>% dplyr::group_by(Regiao,Programa)
datasusPrograma %>% summarise(Media=mean(Obitos))                       

# Tratando valores ausentes
dados2 <- dados
dados2$Obitos[4]<-NA
dados2$`obitos fetais`[23:25]<- NA
dados2$`obitos fetais`[7:8] <- NA

# Identificando NA
sum(is.na(dados2$Obitos))
sum(is.na(dados2$`obitos fetais`))
stats::complete.cases(dados2)

# Mostrando apenas linhas completas
dados2[stats::complete.cases(dados2),]

# Mostrando apenas linhas INCOMPLETAS
dados2[!stats::complete.cases(dados2),]

# Identificando NA em colunas
sum(is.na(dados2))

# Funcao para identificar NAs em colunas de data frames
funcaoNA <- function(df){
  
  library(pacman)
  pacman::p_load(dplyr)
  
  index_col_na <- NULL
  quantidade_na <- NULL
  
  for (i in 1:ncol(df)) {
    if(sum(is.na(df[,i])) > 0) {
      index_col_na[i] <- i
      quantidade_na[i] <- sum(is.na(df[,i]))
    }
  }
  resultados <- data.frame(index_col_na,quantidade_na)
  resultados <- resultados %>% filter(quantidade_na>0)
  return(resultados)
}

funcaoNA(dados2)

# Identificando linhas dos Na
pacman::p_load(na.tools)
which_na(dados2[,3])
which_na(dados2[,4])

dados2[which_na(dados2[,3]),]
dados2[which_na(dados2[,4]),]

# Excluindo dados NA
dados_sem_NA <- dados2[complete.cases(dados2),]
dados_sem_NA <- as.tibble(dados_sem_NA)

# Omitindo NA
stats::na.omit(dados2)

# Estatistica de banco com NA
summary(dados2)

# Medias de variavel com NA
mean(dados2$Obitos, na.rm = TRUE)
mean(stats::na.omit(dados2$Obitos))

# Substituindo NA por inputacao
# A mesma logica abaixo serve para vizinhos
dados3 <- dados2
dados3$Obitos[4] <- mean(stats::na.omit(dados3$Obitos))

# Inputacao por perfil
dados4 <- dados2 %>% group_by(Regiao)
mediasRegioes <- dados4 %>% summarise(MediaObitos=mean(Obitos, na.rm = TRUE))
dados4$Obitos[4] <- mediasRegioes$MediaObitos[3]
