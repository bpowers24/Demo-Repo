# Author: Ryder Runkle
# Date Created: 2026-06-22
# Date Updated: 2026-06-22

# Load necessary libraries
library("ggplot2")
library("patchwork")
library("ggcorrplot")
library("dplyr")

# Create data drame to use for rest of tasks
penguins = read.csv("data/penguin_measurements.csv") %>%
  left_join(read.csv("data/penguin_species.csv"), by = "species_id")

# Create point plot
pointplot = ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(size = 2, color = "red") +
  labs( x = "Bill Length (mm)", y = "Body Mass (g)",
       title = "Body Mass Based on Bill Length")

# Create bar plot
barplot = ggplot(data = penguins, mapping = aes(x = island, fill = common_name)) +
  geom_bar() +
  scale_fill_manual(values = c("red", "yellow", "blue")) + 
  labs(x = "Name of Island", y = "Species",
       title = "Species by Island")

# Create plot using `facet_wrap`
flipperplot = ggplot(data = penguins, mapping = aes(x = sex, y = flipper_length_mm, color = sex)) +
  geom_point(size = 2) +
  scale_color_manual(values = c("female" = "pink", "male" = "blue")) +
  facet_wrap(~island) +
  labs(x = "Sex", y = "Flipper Length",
       title = "Flipper Length by Sex by Island")

# Explore other geom plots
bodymassplot = ggplot(data = penguins, mapping = aes(x = common_name, y = body_mass_g, fill = common_name)) +
  geom_violin() +
  scale_fill_manual(values = c("red", "yellow", "blue")) + 
  labs(x = "Species", y = "Body Mass (g)",
       title = "Body Mass Distribution by Species")

# Use Patch work to combine two plots
patchplot = barplot + bodymassplot +
  plot_annotation(title = "Penguin Species Overview") &
  theme_minimal()

# Save the plots
dir.create("analyses/exploratory_plots/figs", recursive = TRUE)
ggsave("analyses/exploratory_plots/figs/pointplot.png", plot = pointplot, width = 7, height = 5)
ggsave("analyses/exploratory_plots/figs/barplot.png", plot = barplot, width = 7, height = 5)
ggsave("analyses/exploratory_plots/figs/flipperplot.png", plot = flipperplot, width = 9, height = 5)
ggsave("analyses/exploratory_plots/figs/bodymassplot.png", plot = bodymassplot, width = 7, height = 5)
ggsave("analyses/exploratory_plots/figs/patchplot.png", plot = patchplot, width = 12, height = 6)
