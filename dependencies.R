# LIST OF REQUIRED PACKAGES -----------------------------------------------

required_packages <- c(
  "checkpoint"
)

# install missing packages

new.packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]

if (length(new.packages)) {
  install.packages(new.packages, dependencies = TRUE)
}

rm(new.packages)

library(checkpoint)
checkpoint(snapshotDate = "2021-01-21")

library(pacman)
library(readr)
library(tidyverse)
library(lubridate)
library(nycflights13)
library(stringr)
library(tibble)
library(readxl)
library(tidyr)
library(magrittr)