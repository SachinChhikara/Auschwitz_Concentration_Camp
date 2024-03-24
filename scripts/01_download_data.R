library(tidyverse)
library(rvest)

url <- "http://70.auschwitz.org/index.php?option=com_content&view=article&id=89&Itemid=173&lang=en"

webpage <- read_html(url)

table <- webpage %>%
  html_node("table") %>%
  html_table()