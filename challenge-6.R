# load packages
library(ggplot2)
library(dplyr)
library(readr)
library(stringr)
library(purrr)
library(ggrepel)

# Stelle den mitgegebenen Plot nach. Alle Daten dafür habt Ihr ja vorliegen!

# load df with all palamentarians  in the German BT
bundestag_2019 <- readRDS("data/bundestag_2019.rds") %>%  janitor:: clean_names()

# load their Nebentätigkeiten
nebeneinkuenfte <- read_csv("data/abgeordnetenwatch_nebeneinkünfte.csv") %>%  
  janitor:: clean_names() %>% 
  mutate(
    name = str_split(name, ", ") %>% map_chr(~rev(.) %>%  paste(collapse = " ")), 
    nebentaetigkeiten = nebentatigkeiten == "ja"
  ) %>% 
  select(-nebentatigkeiten, -partei)

# join data
data <- bundestag_2019 %>% 
  left_join(nebeneinkuenfte)

# some preparation
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

options(scipen = 999)

# create plot
ggplot(data= data, aes(x = lebensdaten, 
                       y = land, 
                       size = mindest_einkunfte_in_euro, 
                       color = fraktion)) +
  geom_point(alpha = 0.5, position = "jitter") +
  scale_color_manual(values = partei_farben) +
  geom_label_repel(show.legend = FALSE, data = data %>% 
                     filter(mindest_einkunfte_in_euro > 450000),
                   aes(label = name),
                   color = "black",
                   size = 3.75,
                   fill = "white") +
  theme_minimal() +
  labs(title = "Nebeneinkünfte der Abgeordneten des 19. Deutschen Bundestags",
       subtitle = "Quelle: abgeordnetenwatch.de",
       x = "Geburtsjahr",
       y = "Bundesland",
       size = "Mindestnebeneinkünfte",
       color = "Fraktion")
  