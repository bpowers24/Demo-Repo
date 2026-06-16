# 0_setup.R
# Author: Bibi Powers-McCormack
# Date Created: 2026-06-01
# # Date Updated: 2026-06-01

# Objective: 
  # Create example data for the `practice collaboration` exercise. 
# Inputs: 
  # N/A
# Outputs: 
  # `data/penguin_species.csv`
  # `data/penguin_measurements.csv`
# Assumptions:
  # This script is not meant to be run by users, but is included for transparency and reproducibility.

### Prep Script ################################################################

# load libraries
library(tidyverse)
library(palmerpenguins)

### Create data ################################################################

# load penguin data
penguins <- palmerpenguins::penguins %>% 
  mutate(penguin_id = row_number()) %>%
  select(penguin_id, everything())

# create species data
penguin_species <- penguins %>% 
  distinct(species) %>% 
  rename(common_name = species) %>%
  mutate(species_id = row_number(), 
         scientific_name = case_when(common_name == "Adelie" ~ "Pygoscelis adeliae",
                                     common_name == "Chinstrap" ~ "Pygoscelis antarctica",
                                     common_name == "Gentoo" ~ "Pygoscelis papua")) %>% 
  select(species_id, common_name, scientific_name)

# create penguin data
penguin_measurements <- penguins %>% 
  left_join(penguin_species, by = c("species" = "common_name")) %>% 
  select(penguin_id, species_id, year, island, sex, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g)

### Export example data ########################################################

write_csv(penguin_species, "data/penguin_species.csv")
write_csv(penguin_measurements, "data/penguin_measurements.csv")