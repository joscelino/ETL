library(pacman)
pacman::p_load(tidyverse, magrittr, dplyr, lubridate, nycflights13)

# Datas hoje
lubridate::today()
lubridate::now()
base::Sys.Date()

# Transformando data ao formato PT-br
base::format(lubridate::today(),"%d/%m/%y")

# Transformando strings em data
base::as.Date("01jan2020","%d %b %y")
base::as.Date("01-jan-2020","%d-%b-%y")
base::as.Date("01/jan/2020","%d/%b/%y")

datas <- c("01-jan-2020", "02-mai-2021", "03-fev-2018")
base::as.Date(datas,"%d-%b-%y")

# Usando o pacote lubridate
lubridate::as_date("2020-01-19")

x <- c("12-10-1989","23-05-1949", "17-08-2020")
lubridate::dmy(x)

y <- c("1989-10-12", "1949-05-23", "2020-08-17")
lubridate::ymd(y)

lubridate::mdy("January 2nd, 1976")
lubridate::dmy("07-Jan-2020")
lubridate::ymd(20200702)

lubridate::dmy_hms("12-07-1989 12:32:56")
lubridate::dmy_hms("12-07-1989 12:32:56", tz="GMT")

# Componentes separados e inseridos em nova variavel pela funcao mutate
nycflights13::flights %>% dplyr::select(year, month, day, hour, minute) %>%
  dplyr::mutate(Data_do_voo=lubridate::make_datetime(year = year, month = month,
                                                     day = day, hour = hour,
                                                     min = minute))

# Alterando nomes das variaveis
dt <- nycflights13::flights %>% dplyr::select(year, month, day, hour, minute) 
base::names(dt) <- c("ano", "mes", "dia", "hora", "minuto")

# Concatenando data completa com hora e minuto
dt %>% dplyr::mutate(Data_do_voo=lubridate::make_datetime(year = ano, month = mes,
                                                     day = dia, hour = hora,
                                                     min = minuto))
# Concatenando data completa SEM hora e minuto
dt %>% dplyr::mutate(Data_do_voo=lubridate::make_date(year = ano, month = mes,
                                                          day = dia))


