# Set the directory containing the CSV files
directory <- "scoring_standard"

# List all CSV files in the directory
files <- list.files(directory, pattern = "\\.csv$", full.names = TRUE)

# Filter files for each year
files_2021 <- grep("_2021\\.csv$", files, value = TRUE)
files_2022 <- grep("_2022\\.csv$", files, value = TRUE)
files_2023 <- grep("_2023\\.csv$", files, value = TRUE)

# Function to read and combine files
combine_files <- function(file_list) {
  combined_data <- lapply(file_list, read.csv) %>%
    bind_rows()
  return(combined_data)
}

# Combine files for each yea
combined_2021 <- combine_files(files_2021)
combined_2022 <- combine_files(files_2022)
combined_2023 <- combine_files(files_2023)

# Write combined data to new CSV files
write.csv(combined_2021, file.path("fullyearstats", "scoring_2021.csv"), row.names = FALSE)
write.csv(combined_2022, file.path("fullyearstats", "scoring_2022.csv"), row.names = FALSE)
write.csv(combined_2023, file.path("fullyearstats", "scoring_2023.csv"), row.names = FALSE)

