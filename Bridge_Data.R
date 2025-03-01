library(tidyverse)

df_ALL <- read.csv("df_ALL.csv")
PortalData <- read.csv("PortalData.csv")

PortalData_New <- PortalData |>
  left_join(df_ALL, by = "Origin")

write.csv(PortalData_New, "PortalData_New.csv", row.names = FALSE)
