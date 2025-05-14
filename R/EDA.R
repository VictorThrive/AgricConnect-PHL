library(tidyverse)
library(readxl)
p_harvest_loss <-  read_excel("new_data/data/post_harvest_losses.xlsx")


p_h_l <- p_harvest_loss |>
  rename(
    state = "States",
    year = "Year",
    losses_tonnes = "Post harvest losses (in tonnes)"
  ) |>
  filter(crop_type %in% c("Maize","Millet","Sorghum","Rice")) |>
  mutate(across(where(is.character), as.factor))

# 1. Overall Trend of Losses Over Time (Line Chart)
  overall_losses_by_year <- p_h_l %>%
  group_by(year,crop_type) %>%
  summarise(total_losses = sum(losses_tonnes))


  ggplot(overall_losses_by_year, aes(x = year, y = total_losses, fill = crop_type)) +
    geom_bar(stat = "identity", position = "dodge") + # Create grouped bars
    labs(title = "Post-Harvest Losses by Year and Crop Type",
         x = "Year",
         y = "Total Losses (tonnes)",
         fill = "Crop Type") + # Set the legend title
    theme_minimal() + # Use a clean theme
    theme(axis.text.x = element_text(angle = 0, hjust = 0.5)) # Adjust x-axis text


