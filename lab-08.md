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

### Exercise 1

``` r
# set url
first_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=0"

# read html page
page <- read_html(first_url)
```

``` r
titles <- page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a") %>%
  html_text() %>% 
  str_squish()
```

``` r
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

### Exercise 9

``` r
uoe_art <- uoe_art %>%
  separate(title, into = c("title", "date"), sep = "\\(") %>%
  mutate(year = str_remove(date, "\\)") %>% as.numeric()) %>%
  select(title, artist, year, ___)
```

    ## Error: <text>:4:31: unexpected input
    ## 3:   mutate(year = str_remove(date, "\\)") %>% as.numeric()) %>%
    ## 4:   select(title, artist, year, _
    ##                                  ^

### Exercise 10

Remove this text, and add your answer for Exercise 10 here. Add code
chunks as needed. Don’t forget to label your code chunk. Do not use
spaces in code chunk labels.

### Exercise 11

…

Add exercise headings as needed.
