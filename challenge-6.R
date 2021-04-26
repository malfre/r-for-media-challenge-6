library(ggplot2)
library(dplyr)
library(readr)
library(stringr)
library(purrr)

# Stelle den mitgegebenen Plot nach. Alle Daten dafür habt Ihr ja vorliegen!

# load df with all palamentarians  in the German BT
# bundestag_2019 <- …

# load their Nebentätigkeiten
# nebeneinkuenfte <- …

partei_farben <- list(
  "CDU" = "black",
  "SPD" = "red",
  "CSU" = "black",
  "FDP" = "yellow",
  "Grüne" = "green",
  "Linke" = "violet",
  "AfD" = "blue",
  "fraktionslos" = "grey"
)

# data <- …

# ggplot(data) + …
  