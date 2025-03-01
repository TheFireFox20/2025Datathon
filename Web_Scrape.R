rm(list = ls())

library(rvest)
library(tidyverse)
library(janitor)
library(htmltools)

years <- c("2021","2022","2023")

url <- "https://www.sports-reference.com/cfb/schools/#schools"

teams <- read_html(url) |>
  html_elements("tr") |>
  html_node("a") |>
  html_attr("href") |>
  as.character()

teams <- teams[!is.na(teams)]


for (i in 57:length(teams)) {
  for (j in 1:length(years)) {
    tryCatch({
    url1 <- paste0("https://www.sports-reference.com/",teams[i],years[j],".html")

    team <- unlist(str_split(unlist(str_split(teams[i], pattern = "schools/"))[2],"/"))[1]

    html_content <- read_html(url1)

    # Passing
    passing_standard <- html_content |>
      html_node("#passing_standard") |>
      html_table(fill = TRUE) |>
      filter(!is.na(Rk))|>
      mutate(Team = team, Year = years[j])

    write.csv(passing_standard,
              paste0("passing_standard/passing_standard","_",team,"_",years[j],".csv"),
              row.names = F)

    # Rushing and Receiving
    rushing_standard <- html_content |>
      html_node("#rushing_standard") |>
      html_table(fill = TRUE) |>
      row_to_names(row_number = 1) |>
      clean_names() |>
      filter(rk != "") |>
      mutate(Team = team, Year = years[j])

    write.csv(rushing_standard,
              paste0("rushing_standard/rushing_standard","_",team,"_",years[j],".csv"),
              row.names = F)

    # Kick and Punt Returns
    kick_return_standard <- html_content |>
      html_node("#kick_return_standard") |>
      html_table(fill = TRUE) |>
      row_to_names(row_number = 1) |>
      clean_names() |>
      filter(rk != "") |>
      mutate(Team = team, Year = years[j])

    write.csv(kick_return_standard,
              paste0("kick_return_standard/kick_return_standard","_",team,"_",years[j],".csv"),
              row.names = F)

    # Defense and Fumble
    defense_standard <- html_content |>
      html_nodes(xpath = "//comment()") |>
      html_text() |>
      HTML()

    defense_standard_html <- read_html(defense_standard) |>
      html_nodes('table.stats_table.sortable.per_toggler.soc#defense_standard') |>
      html_table()

    defense_standard_final <- defense_standard_html[[1]] |>
      row_to_names(row_number = 1) |>
      clean_names() |>
      filter(rk != "") |>
      mutate(Team = team, Year = years[j])

    write.csv(defense_standard_final,
              paste0("defense_standard/defense_standard","_",team,"_",years[j],".csv"),
              row.names = F)

    # Kicking and Punting
    kicking_standard <- html_content |>
      html_nodes(xpath = "//comment()") |>
      html_text() |>
      HTML()

    kicking_standard_html <- read_html(kicking_standard) |>
      html_nodes('table.stats_table.sortable.per_toggler.soc#kicking_standard') |>
      html_table()

    kicking_standard_final <- kicking_standard_html[[1]] |>
      row_to_names(row_number = 1) |>
      clean_names() |>
      filter(rk != "") |>
      mutate(Team = team, Year = years[j])

    write.csv(kicking_standard_final,
              paste0("kicking_standard/kicking_standard","_",team,"_",years[j],".csv"),
              row.names = F)

    # Scoring
    scoring_standard <- html_content |>
      html_nodes(xpath = "//comment()") |>
      html_text() |>
      HTML()

    scoring_standard_html <- read_html(scoring_standard) |>
      html_nodes('table.stats_table.sortable.per_toggler.soc#scoring_standard') |>
      html_table()

    scoring_standard_final <- scoring_standard_html[[1]] |>
      row_to_names(row_number = 1) |>
      clean_names() |>
      filter(rk != "") |>
      mutate(Team = team, Year = years[j])

    write.csv(scoring_standard_final,
              paste0("scoring_standard/scoring_standard","_",team,"_",years[j],".csv"),
              row.names = F)

    print(i)
    Sys.sleep(10)
    }, error = function(e) {
      print(i)
      return(NULL)
    })
  }
}

