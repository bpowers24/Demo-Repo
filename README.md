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
- Team B: Dillman, Lupita, Jake

## Tasks
A copy of the tasks are provided in this readme for general reference. Please refer to the [GitHub Issues](https://github.com/bpowers24/Demo-Repo/issues) tab for more specifics during the workshop.  
### Task 1: Clean up repo
To prepare for this project, everyone should complete the following. 
- [ ] Delete the `Demo_Repo` from your local computer.
- [ ] Go to GitHub and (re)clone the `Demo-Repo` onto your computer. 
### Task 2: Write a script to QAQC the data
Team A: write code to add `is_overweight` column
- [ ] Pull/fetch recent changes in GitHub desktop. 
- [ ] Create a new branch called `qaqc_for_overweight`.
- [ ] On the new branch, open the `zoo_project.Rproj` file.
- [ ] Open `QAQC_zoo_animals.R`.
- [ ] "Write" code to add a column called `is_overweight`. There is a previous commit that has the code you need. Locate the commit history and find the commit "answers here". Copy and paste the code from an older version of `QAQC_zoo_animals.R`. 
- [ ] When finished, commit your changes. 
- [ ] Return to GitHub web browser and submit a Pull Request.

Team B: review `is_overweight` PR
- [ ] Open the pull request in GitHub web browser.
- [ ] Look through the changes they proposed. 
- [ ] If you agree with them, accept their pull request. 
- [ ] Delete the branch. Notify Team A and have them delete the branch on their local machines. 

Team B: write code to add `is_threatened` column
- [ ] Pull/fetch recent changes in GitHub desktop. 
- [ ] After the `is_overweight` branch has been merged, create a new branch called `qaqc_for_threatened`.
- [ ] On the new branch, open the `zoo_project.Rproj` file. 
- [ ] Open `QAQC_zoo_animals.R`.
- [ ] "Write" code to add a column called `is_threatened`. There is a previous commit that has the code you need. Locate the commit history and find the commit "answers here". Copy and paste the code from an older version of `QAQC_zoo_animals.R`. 
- [ ] When finished, commit your changes. 
- [ ] Return to GitHub web browser and submit a Pull Request. 

Team A: review `is_threatened` PR
- [ ] Open the pull request in GitHub web browser.
- [ ] Look through the changes they proposed. 
- [ ] If you agree with them, accept their pull request. 
- [ ] Delete the branch. Notify Team B and have them delete the branch on their local machines. 

### Task 3: Plot results and answer our objectives
1. Which zoos have a threatened species? 
2. Of the threatened species, how many of those individuals are outside of their normal weight? 

Everyone should complete the following:  
- [ ] Pull/fetch recent changes in GitHub desktop. 
- [ ] On the main branch, open the `zoo_project.Rproj` file. 
- [ ] Open `QAQC_zoo_animals.R`.
- [ ] Run the entire script. 
- [ ] Use the plots to answer the questions. 
- [ ] Return to this GitHub issue and post your answers as a comment. 

## Resources
- For help with GitHub related tasks, see [GitHub_Resources](https://github.com/bpowers24/Demo-Repo/blob/create-zoo-project/GitHub_Resources.md).
- For coding help, see [project_answer_sheet.md](https://github.com/bpowers24/Demo-Repo/blob/create-zoo-project/project_answer_sheet.md).
