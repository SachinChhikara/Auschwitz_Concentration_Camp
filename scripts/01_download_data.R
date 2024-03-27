library(tidyverse)
library(rvest)

url <- "http://70.auschwitz.org/index.php?option=com_content&view=article&id=89&Itemid=173&lang=en"

webpage <- read_html(url)

raw_data <- webpage %>%
  html_node("table") %>%
  html_table()

write.csv(raw_data, 'data/raw_data/auschwitz_camp_webscrape_data.csv')