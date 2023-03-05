# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

# function: scrape_page --------------------------------------------------------

scrape_page <- function(url){
  
  # read page
  page <- read_html(url)
  
  # scrape titles
  titles <- page %>%
    html_nodes(".iteminfo") %>%
    html_node("h3 a") %>%
    html_text() %>% 
    str_squish()
  
  # scrape links
  links <- page %>%
    html_nodes(".iteminfo") %>%   # same nodes
    html_node("h3 a") %>%         # as before
    html_attr("href") %>%         # but get href attribute instead of text
    str_replace(pattern =".", replacement = "https://collections.ed.ac.uk") #replacing
  
  # scrape artists 
  names <- page %>% 
    html_nodes(".iteminfo") %>% 
    html_node(".artist") %>% 
    html_attr("title")
  
  # create and return tibble
  tibble(title = titles, 
         name = names,
         link = links)
  
}

# Test function -----------------------------------------------------------

scrape_page(first_url)
scrape_page(second_url)

