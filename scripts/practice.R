# practice-test.R 
# Author: Ryder Runkle
# Date Created: 2026-06-16
# Date Updates: 2026-06-16

# Load libraries necessary for the tasks
library("tidyverse")
library("testthat")

# Create Data frames so to make csv data usable in R.
penguin_species = read_csv("data/penguin_species.csv")
penguin_measurements = read_csv("data/penguin_measurements.csv")

# Joined Data frames so that I can later use species to identify average body masss. 
joined_data = left_join(penguin_species, penguin_measurements, by = "species_id")

# Create final data frame that shows the average body mass by islands
island_body_mass = group_by(joined_data, island)
island_body_mass = summarize(island_body_mass, mean_body_mass_g = mean(body_mass_g, na.rm = TRUE), .groups = "drop")
print(island_body_mass, digits = 16)

