# Author: Ryder Runkle
# Date Created: 2026-06-22
# Date Updated: 2026-06-22

# Load necessary libraries
library("ggplot2")
library("patchwork")
library("ggcorrplot")
library("dplyr")

# Create Data Frame to use for rest of tasks
penguins = read.csv("data/penguin_measurements.csv") %>%
  left_join(read.csv("data/penguin_species.csv"), by = "species_id")

