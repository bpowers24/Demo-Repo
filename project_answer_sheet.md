# Code Answers

``` R
# QAQC_zoo_animals.R ###########################################################

# Objectives: 
  # 1. Read in raw data file.
  # 2. Add a logical (T/F) column called `is_underweight` to indicate if the animal is underweight.
  # 3. Add a logical (T/F) column called `is_overweight` to indicate if the animal is overweight. 
  # 4. Add a logical (T/F) column called `is_threatened` to indicate if the animal is threatened (is critically endangered, endangered, or vulnerable).
  # 5. Use the plots to determine the answers to our questions. 

### Prep Script ################################################################

# load libraries
library(tidyverse)
library(testthat) # run install.packages("testthat") if you don't have this package

### 1. Read in data ############################################################

zoo_animals_raw <- read_csv("./Data/1_raw/zoo_animals_raw.csv")
weight_parameters <- read_csv("./Data/0_QAQC/weight_parameters.csv")
listing_status <- read_csv("./Data/0_QAQC/endangered_status.csv")

### 2. Create `is_underweight` #################################################

# write your code here
zoo_animals_processed <- zoo_animals_raw %>% 
  left_join(weight_parameters, by = "species") %>% # join the weight df to the raw data
  mutate(is_underweight = case_when(weight < min_weight ~ TRUE, # if the weight is less than the min weight, write "TRUE"
                                    TRUE ~ FALSE)) %>% # otherwise write "FALSE"
  select(colnames(zoo_animals_raw), is_underweight) # select only the original columns plus the new is_underweight col


# run this code to check your answer
test_that("Data frames are equal", {
  expect_equal(nrow(zoo_animals_processed), 20) # expect df to have 20 rows
  expect_equal(colnames(zoo_animals_processed), c("zoo_name", "animal_id", "species", "weight", "is_underweight")) # expect that column names match
  expect_equal(zoo_animals_processed$is_underweight, c(FALSE, FALSE, FALSE,  TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,  TRUE, FALSE, FALSE, FALSE, TRUE)) # expect new is_underweight column to have these values
})


### 3. Create `is_overweight` ##################################################

# write your code here
zoo_animals_processed <- zoo_animals_processed %>% 
  left_join(weight_parameters, by = "species") %>% 
  mutate(is_overweight = case_when(weight > max_weight ~ TRUE, 
                                   TRUE ~ FALSE)) %>% 
  select(colnames(zoo_animals_processed), is_overweight)


# run this code to check your answer
test_that("Data frames are equal", {
  expect_equal(nrow(zoo_animals_processed), 20) # expect df to have 20 rows
  expect_equal(colnames(zoo_animals_processed), c("zoo_name", "animal_id", "species", "weight", "is_underweight", "is_overweight")) # expect that column names match
  expect_equal(zoo_animals_processed$is_underweight, c(FALSE, FALSE, FALSE,  TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,  TRUE, FALSE, FALSE, FALSE, TRUE)) # expect new is_underweight column to have these values
  expect_equal(zoo_animals_processed$is_overweight, c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,  TRUE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)) # expect new is_overweight column to have these values
})


### 4. Create `is_threatened` ##################################################

# write your code here
zoo_animals_processed <- zoo_animals_processed %>% 
  left_join(listing_status, by = "species") %>% 
  mutate(is_threatened = case_when(iucn_listing_status %in% c("critically endangered", "endangered", "vulnerable") ~ TRUE, 
                                   TRUE ~ FALSE)) %>% 
  select(colnames(zoo_animals_processed), is_threatened)


# run this code to check your answer
test_that("Data frames are equal", {
  expect_equal(nrow(zoo_animals_processed), 20) # expect df to have 20 rows
  expect_equal(colnames(zoo_animals_processed), c("zoo_name", "animal_id", "species", "weight", "is_underweight", "is_overweight", "is_threatened")) # expect that column names match
  expect_equal(zoo_animals_processed$is_underweight, c(FALSE, FALSE, FALSE,  TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,  TRUE, FALSE, FALSE, FALSE, TRUE)) # expect new is_underweight column to have these values
  expect_equal(zoo_animals_processed$is_overweight, c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,  TRUE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)) # expect new is_overweight column to have these values
  expect_equal(zoo_animals_processed$is_threatened, c(FALSE,  TRUE,  TRUE,  TRUE,  TRUE, FALSE, TRUE,  TRUE,  TRUE, TRUE, FALSE,  TRUE,  TRUE,  TRUE,  TRUE,  TRUE, TRUE, TRUE, TRUE, FALSE)) # expect new is_threatened column to have these values
})


### 5. Plot results ############################################################

#### Plot A ####
# checking if threatened species were correctly identified: 
  # atlanta 1/2
  # bronx 2/2
  # denver 2/2
  # oregon 1/2
  # san diego 5/6
  # smithsonian 2/2
  # woodland park 2/3

plot_a <- zoo_animals_processed %>%
  group_by(zoo_name, is_threatened) %>% 
  summarise(number_of_species = n()) %>% 
  ungroup() %>% 
  
  ggplot(data = ., mapping = aes(x = zoo_name, y = number_of_species, fill = is_threatened)) +
  geom_bar(stat = "identity") +
  labs(title = "Species at Zoos",
       x = "Zoo Name",
       y = "Number of Species",
       fill = "Is Threatened") +
  scale_fill_manual(values = c("TRUE" = "red", "FALSE" = "gray")) +
  theme_minimal()

plot_a


#### Plot B ####
# checking if weight status was correctly identified for threatened species: 
  # giant panda: 1 under, 2 normal
  # hawksbill turtle: 2 normal, 1 over
  # lion: 1 under, 1 normal, 1 over
  # sumatran orangutan: 1 normal, 1 over
  # tiger: 4 normal

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
```
