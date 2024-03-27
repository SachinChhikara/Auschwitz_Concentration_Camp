library(tidyr)
library(dplyr)

raw_data <- read.csv('data/raw_data/auschwitz_camp_webscrape_data.csv')


clean_data <-
  raw_data[-c(1, nrow(raw_data)),] |>
  select(X1, X2, X4) |>
  rename(Nationality = X1, Number_of_deportees = X2, Number_of_victims = X4)


# Remove non-numeric characters and convert to numeric
clean_data$Number_of_deportees <- gsub("[^0-9.]", "", clean_data$Number_of_deportees)
clean_data$Number_of_deportees <- as.numeric(clean_data$Number_of_deportees)

clean_data$Number_of_victims <- gsub("[^0-9.]", "", clean_data$Number_of_victims)
clean_data$Number_of_victims <- as.numeric(clean_data$Number_of_victims)

#adds the zeroes
clean_data$Number_of_deportees[-1] <- clean_data$Number_of_deportees[-1] * 1000
clean_data$Number_of_victims[-1] <- clean_data$Number_of_victims[-1] * 1000

clean_data$Number_of_deportees[1] <- clean_data$Number_of_deportees[1] * 1000000
clean_data$Number_of_victims[1] <- clean_data$Number_of_victims[1] * 1000000 

#formatting with commas for trailing zeroes
clean_data$Number_of_deportees <- format(clean_data$Number_of_deportees, big.mark = ",")
clean_data$Number_of_victims <- format(clean_data$Number_of_victims, big.mark = ",")


write.csv(clean_data, 'data/analysis_data/analyis_data.csv')

