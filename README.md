# Demo-Repo - Zoo Project

## Objective
Create a curriculum that uses a shared project to teach a group of 5ish people about using branches in GitHub. The goal is to cover the following topics: merging, pull requests, branches, and cloning. 
## Scenario
There is an ongoing (simulated) dataset on zoos across the country studying the health of individuals. We will refine, clean, and analyze the data collected from zoos across the country. 
## Data
The example dataset includes weight data on 16 animals across 7 zoos. There are two additional files that will be used to parametrize the QAQC process. 
- `zoo_animals.csv` is a 4 column dataset, where each row is an individual animal. 
	- `zoo_name`: {text} The name of the zoo.
	- `animal_id`: {text} A unique identifier for each animal in the zoo.
	- `species`: {text} The species of the animal.
	- `weight`: {numeric} The weight of the animal in kilograms. 
- `endangered_status.csv` is a 2 column table, where each row lists a species and their IUCN listing. 
	- `species`: {text} The common name of the species.
	- `iucn_listing_status`: {text} The listing status based on a species' risk of extinction from a controlled vocabulary list (extinct, extinct in the wild, critically endangered, endangered, vulnerable, near threatened, least concern, data deficient, and not evaluated). Note that the following categories are collectively referred to as "threatened": critically endangered, endangered, and vulnerable. 
- `weight_parameters.csv` is a 3 column table, where each row lists a species and their minimum and maximum weight. 
	- `species`: {text} The common name of the species. 
	- `min_weight`: {numeric} The average minimum weight of the animal in kilograms. 
	- `max_weight`: {numeric} The average maximum weight of the animal in kilograms. 
## Teams
- Team A: Vanessa, Maggi, Sophia
- Team B: Dillman, Lupita
- Team C: Bibi, Brie
## Task 1: Clean up repo
To prepare for this project, everyone should complete the following. 
- [ ] Delete the `Demo_Repo` from your local computer.
- [ ] Go to GitHub and (re)clone the `Demo-Repo` onto your computer. 
## Task 2: Write a script to QAQC the data
Team A: write code to add `is_overweight` column
- [ ] Create a new branch called `qaqc_for_overweight`.
- [ ] On the new branch, open the `zoo_project.Rproj` file.
- [ ] Open `QAQA_zoo_animals.R`.
- [ ] Write code to add a column called `is_overweight`. If the weight of an animal in the `zoo_animals.csv` file is greater than the maximum value in the `weight_parameters.csv` file, then indicate "TRUE". Otherwise indicate "FALSE".
- [ ] When finished, commit your changes. 
- [ ] Return to GitHub web browser and submit a Pull Request.

Team B: review `is_overweight` PR
- [ ] Open the pull request in GitHub web browser.
- [ ] Look through the changes they proposed. 
- [ ] If you agree with them, accept their pull request. 
- [ ] Delete the branch. Notify Team A and have them delete the branch on their local machines. 

Team B: write code to add `is_threatened` column
- [ ] After the `is_overweight` branch has been merged, create a new branch called `qaqc_for_threatened`.
- [ ] On the new branch, open the `zoo_project.Rproj` file. 
- [ ] Open `QAQC_zoo_animals.R`.
- [ ] Write code to add a column called `is_threatened`. If the endangered listing status of an animal in the `zoo_animals.csv` file is "endangered", "critically endangered", or "vulnerable", then the threatened status should indicated "TRUE". Otherwise indicate "FALSE". 
- [ ] When finished commit, your changes. 
- [ ] Return to GitHub web browser and submit a Pull Request. 

Team A: review `is_threatened` PR
- [ ] Open the pull request in GitHub web browser.
- [ ] Look through the changes they proposed. 
- [ ] If you agree with them, accept their pull request. 
- [ ] Delete the branch. Notify Team B and have them delete the branch on their local machines. 

## Task 3: Create `zoo_animals_processed.csv` and plots
Team C: 
- [ ] Create a new branch called `create_processed_file`.
- [ ] On the new branch, open the `zoo_project.Rproj` file. 
- [ ] Open the `QAQC_zoo_aniamls.R` file and run the script, including writing out the new `zoo_animals_processed.csv` file. 
- [ ] Open `plots_zoo_animals.R` script and run it. 
- [ ] Compare plots to the answer plots in the Figures folder. 
	- [ ] If the figures look good, then commit your changes. 
	- [ ] If there is an issue, then submit an issue and assign Bibi to it. 
		- [ ] Bibi will go to that branch and make any changes needed to fix the code. Commit and push. 
		- [ ] Brie will pull and try to run the scripts again. If figures look good, then will commit changes. 
- [ ] Return to GitHub web browser and submit a pull request. 
- [ ] Bibi will review and accept the pull request. 

## Code Answers
``` R 
# QAQC_zoo_animals.R ###########################################################

# Objectives: 
  # 1. Read in raw data file.
  # 2. Add a logical (T/F) column called `is_underweight` to indicate if the animal is underweight.
  # 3. Add a logical (T/F) column called `is_overweight` to indicate if the animal is overweight. 
  # 4. Add a logical (T/F) column called `is_threatened` to indicate if the animal is threatened (is critically endangered, endangered, or threatened).
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

zoo_animals_processed <- zoo_animals_processed %>% 
  left_join(weight_parameters, by = "species") %>% 
  mutate(is_overweight = case_when(weight > max_weight ~ TRUE, 
                                    TRUE ~ FALSE)) %>% 
  select(colnames(zoo_animals_processed), is_overweight) 


### 4. Create `is_threatened` ##################################################
# tip: use `iucn_listing_status %in% c("critically endangered", "endangered", "vulnerable")` in your case_when() statement

zoo_animals_processed <- zoo_animals_processed %>% 
  left_join(listing_status, by = "species") %>% 
  mutate(is_threatened = case_when(iucn_listing_status %in% c("critically endangered", "endangered", "vulnerable") ~ TRUE, 
                                   TRUE ~ FALSE)) %>% 
  select(colnames(zoo_animals_processed), is_threatened)


### 5. Export processed data ###################################################

write_csv(zoo_animals_processed, "./Data/2_processed/zoo_animals_processed.csv")
```
