# QAQC_zoo_animals.R ###########################################################

# Objectives: 
  # 1. Read in raw data file.
  # 2. Add a logical (T/F) column called `is_underweight` to indicate if the animal is underweight.
  # 3. Add a logical (T/F) column called `is_overweight` to indicate if the animal is overweight. 
  # 4. Add a logical (T/F) column called `is_threatened` to indicate if the animal is threatened (is critically endangered, endangered, or vulnerable).
  # 5. Export the new files called `zoo_animals_processed.csv` to the Data/2_processed folder.

### Prep Script ################################################################

# load libraries
library(tidyverse)

### 1. Read in data ############################################################

zoo_animals_raw <- read_csv("./Data/1_raw/zoo_animals_raw.csv")
weight_parameters <- read_csv("./Data/0_QAQC/weight_parameters.csv")
listing_status <- read_csv("./Data/0_QAQC/endangered_status.csv")

### 2. Create `is_underweight` #################################################

zoo_animals_processed <- zoo_animals_raw %>% 
  left_join(weight_parameters, by = "species") %>% # join the weight df to the raw data
  mutate(is_underweight = case_when(weight < min_weight ~ TRUE, # if the weight is less than the min weight, write "TRUE"
                                    TRUE ~ FALSE)) %>% # otherwise write "FALSE"
  select(colnames(zoo_animals_raw), is_underweight) # select only the original columns plus the new is_underweight col


### 3. Create `is_overweight` ##################################################




### 4. Create `is_threatened` ##################################################
# tip: use `iucn_listing_status %in% c("critically endangered", "endangered", "vulnerable")` in your case_when() statement




### 5. Export processed data ###################################################

write_csv(zoo_animals_processed, "./Data/2_processed/zoo_animals_processed.csv")
