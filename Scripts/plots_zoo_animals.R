# plots_zoo_animals.R ##########################################################

# Objectives: 
  # Create plots with the processed data
  # Plot A: Bar graph with species_name on X, number of zoos on Y. Color the threatened species. 
  # Plot B: Point graph with species on X, weight on Y. Include the normal range and color the animals by weight status.  

### Prep script ################################################################

# load libraries
library(tidyverse)

### Read in data ###############################################################

zoo_animals_processed <- read_csv("./Data/2_processed/zoo_animals_processed.csv")
weight_parameters <- read_csv("./Data/0_QAQC/weight_parameters.csv")

### Plot A #####################################################################
# checking if threatened species were correctly identified: 
  # 3 giant panda
  # 2 hawksbill turtle
  # 3 lion
  # 2 sumantran orangutan
  # 2 tiger

plot_a <- zoo_animals_processed %>% 
  group_by(species, is_threatened) %>% 
  summarise(number_of_zoos = n()) %>% 
  ungroup() %>% 
  
ggplot(data = ., mapping = aes(x = species, y = number_of_zoos, fill = is_threatened)) +
  geom_bar(stat = "identity") +
  labs(title = "Species at Zoos",
       x = "Species",
       y = "Number of Zoos",
       fill = "Is Threatened") +
  scale_fill_manual(values = c("TRUE" = "red", "FALSE" = "gray")) +
  theme_minimal()

plot_a


### Plot B #####################################################################
# checking if weight status was correctly identified for threatened species: 
  # giant panda: 1 under, 2 normal
  # hawksbill turtle: 1 under, 1 normal
  # lion: 2 normal, 1 over
  # sumatran orangutan: 1 normal, 1 over
  # tiger: 2 normal

plot_b <- zoo_animals_processed %>% 
  left_join(weight_parameters, by = "species") %>% 
  mutate(weight_status = case_when(is_underweight == TRUE ~ "underweight", 
                                   is_overweight == TRUE ~ "overweight",
                                   T ~ "normal")) %>% 
  filter(is_threatened == TRUE) %>%
  
ggplot(data = ., mapping = aes(x = species)) +
  geom_point(aes(y = weight, color = weight_status), size = 4) + 
  geom_linerange(aes(ymin = min_weight, ymax = max_weight), color = "gray50", alpha = 0.25, size = 2) +
  scale_color_manual(values = c("underweight" = "red", "overweight" = "purple", "normal" = "green")) +
  labs(title = "Weight status of threatened zoo animals",
       x = "Species",
       y = "Weight (kg)",
       color = "Weight Status") +
  theme_minimal()

plot_b


### Export Plots ###############################################################

ggsave(filename = "./Figures/plot_a.png", plot = plot_a, bg = "white", width = 12, height = 5)
ggsave(filename = "./Figures/plot_b.png", plot = plot_b, bg = "white", width = 8, height = 10)
