

# Install and load the rvest package
library(rvest)

# Specify the URL of the webpage
url <- "https://newsday.sportsdirectinc.com/football/ncaaf-players.aspx?page=/data/ncaaf/players/G_players.html"

# Read the HTML content from the webpage
webpage <- read_html(url)

# Extract the table data (assuming the table has a specific class or id)
table <- webpage %>%
  html_element("table") %>%  # Adjust the selector based on the actual table structure
  html_table()

# View the extracted table
print(table)




# Install and load the necessary packages
library(rvest)
library(httr)

# Specify the URL of the webpage
url <- "https://newsday.sportsdirectinc.com/football/ncaaf-players.aspx?page=/data/ncaaf/players/G_players.html"

# Use httr to get the webpage content
webpage <- GET(url)

# Parse the HTML content
content <- content(webpage, as = "text")
parsed_html <- read_html(content)

# Extract the table data (adjust the selector based on the actual table structure)
table <- parsed_html %>%
  html_node("table") %>%  # Adjust the selector based on the actual table structure
  html_table()

# View the extracted table
print(table)
