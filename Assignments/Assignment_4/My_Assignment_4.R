install.packages("maps")
dev.off()
par(mar = c(0, 0, 0, 0))
map('state', fill = TRUE, col = 'grey', border = 'black', lwd = 0.5)
library(RColorBrewer)
install.packages("RColorBrewer")
resistance_data = data.frame(state = tolower(state.name))
resistance_data = resistance_data %>% 
  mutate(resistance = sample(1:100, n(), replace = TRUE),
    bin = cut(resistance,
              breaks = c(0, 25, 50, 75, 100),
              labels = FALSE,
              include.lowest = TRUE),
    color = brewer.pal(4, "Reds")[bin]
    library(ggplot2)
    
map_df = map_data("state")
map_df = left_join(map_df, resistance_data,
                    by = c("region" = "state"))
  ggplot(map_df, aes(long, lat, group = group, fill = resistance)) +
      geom_polygon(color = "black") +
      scale_fill_distiller(palette = "Reds") +
      theme_void()
    






