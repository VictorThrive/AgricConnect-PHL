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


  
  library(readxl)
  library(purrr) # or library(dplyr)
  
  # Specify the path to the directory containing your Excel files
  data_directory <- "dataset/other_datasets/"
  
  # Get a list of all Excel files in the directory
  excel_files <- list.files(data_directory, pattern = "\\.xlsx$", full.names = TRUE)
  
  # Read all Excel files into a list of data frames
  # Using purrr's map function
  data_list <- map(excel_files, read_excel)
  
  # Optionally, you can name the elements of the list based on the file names
  names(data_list) <- tools::file_path_sans_ext(basename(excel_files))
  
  # Now, data_list is a list where each element is a data frame
  # corresponding to one of your Excel files.
  
  # You can access individual data frames like this:
  # data_list$population  # if population.xlsx was one of the files
  
  # If you want to view one of the data frames, for example the first one:
  
  
  names(data_list[[1]])
  names(data_list[[2]])
  names(data_list[[3]])
  names(data_list[[4]])
  names(data_list[[5]])
  
  # Load libraries
  library(readxl)
  library(dplyr)
  library(ggplot2)
  
  library(dplyr)
  library(lubridate)
  
  df_cleaned <- data_list[[2]] %>%
    mutate(
      date = mdy(date), # Convert date to a Date type
      market_id = as.numeric(market_id), # Convert market_id to numeric
      latitude = as.numeric(latitude),   # Convert latitude to numeric
      longitude = as.numeric(longitude),  # Convert longitude to numeric
      `price(NGN)` = as.numeric(`price(NGN)`), # Convert price(NGN) to numeric
      `price(USD)` = as.numeric(`price(USD)`)  # Convert price(USD) to numeric
    )
  
  
  # Major Insight Example for Logistics
  data_list[[2]] %>%
    group_by(State) %>%
    mutate(`price(NGN)` = as.numeric(gsub("[^0-9.]", "", `price(NGN)`))) %>% # Remove non-numeric characters except decimal point
    summarise(Avg_Price = mean(`price(NGN)`, na.rm = TRUE))
  
  
