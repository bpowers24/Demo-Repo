# practice-test.R 
# Author: Bibi Powers-McCormack
# Date Created: 2026-06-01
# Date Updated: 2026-06-01

# Objective: This script is meant to confirm the results created by students. 
# Inputs: 
  # `scripts/practice.R`
# Outputs: 
  # N/A
# Assumptions: 
  # The student created a script called `practice.R` that contains code to create an object called `island_body_mass` that contains the average body mass of Adelie penguins by island.

### Prep Script ################################################################
# load libraries
library(tidyverse)
library(testthat)

# cofirm that working directory is set to `Demo-Repo` folder
getwd() 

# load data
source("scripts/practice.R")

# Tests ########################################################################

# check that object `island_body_mass` exists
test_that("object `island_body_mass` exists", {
  expect_true(exists("island_body_mass"), 
  label = "The object `island_body_mass` does not exist. Please check that you have created an object with this name in your `practice.R` script.")
})

# check that columns within `island_body_mass` are correct
test_that("columns within `island_body_mass` are correct", {
  expect_true(all(c("island", "mean_body_mass_g") %in% colnames(island_body_mass)), 
  label = "The object `island_body_mass` does not contain the correct columns. Please check that you have created an object with this name in your `practice.R` script and that it contains the columns `common_name`, `island`, and `mean_body_mass_g`.")
})


# check that there are no missing values in the `mean_body_mass_g` column within `island_body_mass`
test_that("no missing values in output", {
  expect_false(any(is.na(island_body_mass$mean_body_mass_g)), 
  label = "The object `island_body_mass` contains missing values in the `mean_body_mass_g` column. Please check that you have created an object with this name in your `practice.R` script and that it contains no missing values.")
})

# check that averaged body mass values within `island_body_mass` are correct
test_that("averaged body mass values within `island_body_mass` are correct", {
  expected <- tibble(island = c("Biscoe", "Dream", "Torgersen"),
                     mean_body_mass_g = c(4716.018, 3712.903, 3706.373))

  expect_equal(island_body_mass %>% 
                select(island, mean_body_mass_g) %>% 
                arrange(island),
              expected %>% 
                arrange(island),
              tolerance = 0.01, 
            label = "The averaged body mass values within the `mean_body_mass_g` column of the `island_body_mass` object are not correct. Please check that you have created an object with this name in your `practice.R` script and that it contains the correct averaged body mass values for each island.")
})

# check that object `adelie_body_mass` exsits 
test_that("object `adelie_body_mass` exists", {
  expect_true(exists("adelie_body_mass"), 
              label = "The object `adelie_body_mass` does not exist. Please check that you have created an object with this name in your `practice.R` script.")
})


# check that only Adelie species is included in data set
test_that("only Adelie is included in adelie_body_mass", {
  expect_true(all(adelie_body_mass$common_name %in% "Adelie"), 
              label = "The object `adelie_body_mass` contains penguins that are not Adelie penguins.")
})

# check that there are no missing values in the `mean_body_mass_g` column within `adelie_body_mass`
test_that("no missing values in output", {
  expect_false(any(is.na(adelie_body_mass$mean_body_mass_g)), 
               label = "The object `adelie_body_mass` contains missing values in the `mean_body_mass_g` column. Please check that you have created an object with this name in your `practice.R` script and that it contains no missing values.")
})

# check that averaged body mass values within `island_body_mass` are correct
test_that("averaged body mass value within `adelie_body_mass` is correct", {
  expected = tibble(common_name = c("Adelie"),
                    mean_body_mass_g = c(3700.662))
  
  expect_equal(adelie_body_mass %>% 
                 select(common_name, mean_body_mass_g),
               expected,
               tolerance = 0.01, 
               label = "The averaged body mass value within `adelie_body_mass` is not correct.")
})
