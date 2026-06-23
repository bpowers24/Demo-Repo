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
pointplot = ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(size = 2, color = "red") +
  labs( x = "Bill Length (mm)", y = "Body Mass (g)",
       title = "Body Mass Based on Bill Length")

# Create Bar Plot
barplot = ggplot(data = penguins, mapping = aes(x = island, fill = common_name)) +
  geom_bar() +
  scale_fill_manual(values = c("red", "yellow", "blue")) + 
  labs(x = "Name of Island", y = "Species",
       title = "Species by Island")

# Create Plot using `facet_wrap`
flipperplot = ggplot(data = penguins, mapping = aes(x = sex, y = flipper_length_mm, color = sex)) +
  geom_point(size = 2) +
  scale_color_manual(values = c("female" = "pink", "male" = "blue")) +
  facet_wrap(~island) +
       title = "Flipper Length by Sex by Island")

