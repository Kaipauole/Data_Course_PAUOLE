# load all necessary libraries 
library(tidyverse)
library(ggplot2)
library(maps)
library(RColorBrewer)

# reading in MRSA data set 
MRSA = read.csv("C:/Users/kaipa/Downloads/Kaipauole.github.io/final_project/Standardized-Infection-Ratios-by-State-Map/Standardized-Infection-Ratios-by-State-Map.csv")

# shows the original data structure 
str(MRSA)

# shows a portion of our updated data set 
head(MRSA)

# raw map used
par(mar = c(0, 0, 0, 0))
map('state', fill = TRUE, col = 'grey', border = 'black', lwd = 0.5)

# map with data
sum(is.na(MRSA$Observed.Infections))
MRSA$State = tolower(MRSA$State)
MRSA$Observed.Infections = as.numeric(MRSA$Observed.Infections)
map_df = map_data("state")

MRSA_map = MRSA %>%
  mutate(bin = cut(Observed.Infections,
                   breaks = c(-Inf, 125, 250, 375, 500, 625, 750, Inf),
                   labels = c("0-125", "126-250", "251-375", "376-500", "501-625", "626-750", "750+"),
                   include.lowest = TRUE))
map_df = left_join(map_df, MRSA_map,
                   by = c("region" = "State"))
ggplot(map_df, aes(long, lat, group = group, fill = bin)) +
  geom_polygon(color = "black") +
  scale_fill_brewer(
    palette = "Reds",
    name = "Observed Infections",
    direction = 1)+
  theme_void()