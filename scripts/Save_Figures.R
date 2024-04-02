library(tidyverse)

data <- read.csv("data/analysis_data/analyis_data.csv")

data$Number_of_deportees <- as.numeric(gsub(",", "", data$Number_of_deportees))
data$Number_of_victims <- as.numeric(gsub(",", "", data$Number_of_victims))
max_value <- max(max(data$Number_of_deportees), max(data$Number_of_victims))

deportees <- ggplot(data, aes(x = Nationality, y = Number_of_deportees)) +
  geom_bar(stat = "identity", fill = "blue") +
  scale_y_continuous(labels = scales::comma, limits = c(0, max_value)) +  # Format y-axis labels with commas
  coord_flip() +
  theme_minimal()


victims <- ggplot(data, aes(x = Nationality, y = Number_of_victims)) +
  geom_bar(stat = "identity", fill = "red") +
  scale_y_continuous(labels = scales::comma, limits = c(0, max_value)) +  # Format y-axis labels with commas
  coord_flip() +
  theme_minimal()

ggsave('figures/deportees.png', deportees)
ggsave('figures/victims.png', victims)