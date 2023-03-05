Lab 08 - University of Edinburgh Art Collection
================
Conor Lacey
03-05-23

### Load packages and data

``` r
suppressWarnings(library(tidyverse))
library(rvest)
library(skimr)
```

    ## Warning: package 'skimr' was built under R version 4.1.2

``` r
library(glue)
```

### Exercise 1

``` r
# set url
first_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=0"

# read html page
page <- read_html(first_url)

titles <- page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a") %>%
  html_text() %>% 
  str_squish()

links <- page %>%
  html_nodes(".iteminfo") %>%   # same nodes
  html_node("h3 a") %>%         # as before
  html_attr("href") %>%         # but get href attribute instead of text
  str_replace(pattern =".", replacement = "https://collections.ed.ac.uk") #replacing
```

### Exercise 2

``` r
names <- page %>% 
  html_nodes(".iteminfo") %>% 
  html_node(".artist") %>% 
  html_attr("title")
```

### Exercise 3

``` r
uoe_art <- tibble(title = titles, 
                  name = names,
                  link = links)
uoe_art
```

    ## # A tibble: 10 × 3
    ##    title                                                        name       link 
    ##    <chr>                                                        <chr>      <chr>
    ##  1 Untitled - Nude Woman in Red Reclining on a Red Couch (1963) Meriel A … http…
    ##  2 Saucer                                                       Emma Gill… http…
    ##  3 Riders from the North Frieze of the Parthenon (1836-1837)    <NA>       http…
    ##  4 From the Viking Age (1897)                                   Pavlov Ch… http…
    ##  5 Farm Building (01 May 1985)                                  Allison E… http…
    ##  6 South Frieze of the Parthenon Frieze (1836-1837)             <NA>       http…
    ##  7 Unknown (1952)                                               Alistair … http…
    ##  8 Townscape with Church (1955)                                 Margaret … http…
    ##  9 Hibernation (1987)                                           Alastair … http…
    ## 10 Saucer                                                       Emma Gill… http…

``` r
# Remove eval = FALSE or set it to TRUE once data is ready to be loaded
uoe_art <- read_csv("data/uoe-art.csv")
```

### Exercise 4

``` r
# set url
second_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=10"

# read html page
page <- read_html(second_url)

titles <- page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a") %>%
  html_text() %>% 
  str_squish()

links <- page %>%
  html_nodes(".iteminfo") %>%   # same nodes
  html_node("h3 a") %>%         # as before
  html_attr("href") %>%         # but get href attribute instead of text
  str_replace(pattern =".", replacement = "https://collections.ed.ac.uk") #replacing

names <- page %>% 
  html_nodes(".iteminfo") %>% 
  html_node(".artist") %>% 
  html_attr("title")

second_ten <- tibble(title = titles, 
                  name = names,
                  link = links)
second_ten
```

    ## # A tibble: 10 × 3
    ##    title                                             name                link   
    ##    <chr>                                             <chr>               <chr>  
    ##  1 Untitled (Unknown)                                Victoria C F Bernie https:…
    ##  2 Lid                                               Emma Gillies        https:…
    ##  3 Espresso Cup                                      Emma Gillies        https:…
    ##  4 Untitled - Portrait of a Reading Woman (Apr 1963) William Gillon      https:…
    ##  5 Portrait of a Woman (1947)                        James Cumming       https:…
    ##  6 Untitled (1967)                                   Christine Watson    https:…
    ##  7 Untitled - Life Drawing of Skeletons (1963)       William O. Little   https:…
    ##  8 Seated Fate, east pediment of the Parthenon       <NA>                https:…
    ##  9 3,500 Men (May 1986)                              Andrew Arnott       https:…
    ## 10 Portrait of a Man (1957)                          Unknown             https:…

### Exercises 5

``` r
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
```

### Exercise 6

``` r
scrape_page(first_url)
```

    ## # A tibble: 10 × 3
    ##    title                                                        name       link 
    ##    <chr>                                                        <chr>      <chr>
    ##  1 Untitled - Nude Woman in Red Reclining on a Red Couch (1963) Meriel A … http…
    ##  2 Saucer                                                       Emma Gill… http…
    ##  3 Riders from the North Frieze of the Parthenon (1836-1837)    <NA>       http…
    ##  4 From the Viking Age (1897)                                   Pavlov Ch… http…
    ##  5 Farm Building (01 May 1985)                                  Allison E… http…
    ##  6 South Frieze of the Parthenon Frieze (1836-1837)             <NA>       http…
    ##  7 Unknown (1952)                                               Alistair … http…
    ##  8 Townscape with Church (1955)                                 Margaret … http…
    ##  9 Hibernation (1987)                                           Alastair … http…
    ## 10 Saucer                                                       Emma Gill… http…

``` r
scrape_page(second_url)
```

    ## # A tibble: 10 × 3
    ##    title                                             name                link   
    ##    <chr>                                             <chr>               <chr>  
    ##  1 Untitled (Unknown)                                Victoria C F Bernie https:…
    ##  2 Lid                                               Emma Gillies        https:…
    ##  3 Espresso Cup                                      Emma Gillies        https:…
    ##  4 Untitled - Portrait of a Reading Woman (Apr 1963) William Gillon      https:…
    ##  5 Portrait of a Woman (1947)                        James Cumming       https:…
    ##  6 Untitled (1967)                                   Christine Watson    https:…
    ##  7 Untitled - Life Drawing of Skeletons (1963)       William O. Little   https:…
    ##  8 Seated Fate, east pediment of the Parthenon       <NA>                https:…
    ##  9 3,500 Men (May 1986)                              Andrew Arnott       https:…
    ## 10 Portrait of a Man (1957)                          Unknown             https:…

### Exercise 7

``` r
# list of urls to be scraped ---------------------------------------------------

root <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset="
numbers <- seq(from = 0, to = 3010, by = 10)
urls <- glue("{root}{numbers}")

# map over all urls and output a data frame ------------------------------------
```

Exercise 8

``` r
uoe_art <- map_dfr(urls, scrape_page)
```

### Exercise 9

``` r
# write out data frame ---------------------------------------------------------
write_csv(uoe_art, file = "data/uoe-art.csv")
```
