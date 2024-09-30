# QAQC_zoo_animals.R ###########################################################

# Objectives: 
  # 1. Read in raw data file.
  # 2. Add a logical (T/F) column called `is_underweight` to indicate if the animal is underweight.
  # 3. Add a logical (T/F) column called `is_overweight` to indicate if the animal is overweight. 
  # 4. Add a logical (T/F) column called `is_threatened` to indicate if the animal is threatened (is critically endangered, endangered, or vulnerable).

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
  expect_equal(nrow(zoo_animals_processed), 16) # expect df to have 16 rows
  expect_equal(colnames(zoo_animals_processed), c("zoo_name", "animal_id", "species", "weight", "is_underweight")) # expect that column names match
  expect_equal(zoo_animals_processed$is_underweight, c(FALSE, FALSE, FALSE,  TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,  TRUE, FALSE, TRUE)) # expect new is_underweight column to have these values
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
  expect_equal(nrow(zoo_animals_processed), 16) # expect df to have 16 rows
  expect_equal(colnames(zoo_animals_processed), c("zoo_name", "animal_id", "species", "weight", "is_underweight", "is_overweight")) # expect that column names match
  expect_equal(zoo_animals_processed$is_underweight, c(FALSE, FALSE, FALSE,  TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,  TRUE, FALSE, TRUE)) # expect new is_underweight column to have these values
  expect_equal(zoo_animals_processed$is_overweight, c(FALSE, FALSE, FALSE, FALSE,  TRUE, FALSE, FALSE, FALSE,  TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)) # expect new is_overweight column to have these values
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
  expect_equal(nrow(zoo_animals_processed), 16) # expect df to have 16 rows
  expect_equal(colnames(zoo_animals_processed), c("zoo_name", "animal_id", "species", "weight", "is_underweight", "is_overweight", "is_threatened")) # expect that column names match
  expect_equal(zoo_animals_processed$is_underweight, c(FALSE, FALSE, FALSE,  TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,  TRUE, FALSE, TRUE)) # expect new is_underweight column to have these values
  expect_equal(zoo_animals_processed$is_overweight, c(FALSE, FALSE, FALSE, FALSE,  TRUE, FALSE, FALSE, FALSE,  TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)) # expect new is_overweight column to have these values
  expect_equal(zoo_animals_processed$is_threatened, c(FALSE,  TRUE,  TRUE,  TRUE,  TRUE, FALSE, FALSE,  TRUE,  TRUE,  TRUE,  TRUE,  TRUE,  TRUE,  TRUE,  TRUE, FALSE)) # expect new is_threatened column to have these values
})



