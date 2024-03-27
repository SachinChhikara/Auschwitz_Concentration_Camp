library(tidyr)
library(dplyr)

raw_data <- read.csv('data/raw_data/auschwitz_camp_webscrape_data.csv')


clean_data <-
  raw_data[-c(1, nrow(raw_data)),] |>
  select(X1, X2, X4) |>
  rename(Nationality = X1, Number_of_deportees = X2, Number_of_victims = X4)

write.csv(clean_data, 'data/analysis_data/analyis_data.csv')

