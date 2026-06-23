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

# Create Point Plot
ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(size = 2, color = "red") +
  labs( x = "Bill Length (mm)", y = "Body Mass (g)",
       title = "Body Mass Based on Bill Length")
