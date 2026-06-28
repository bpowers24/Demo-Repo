## Author: Ryder Runkle
## Date Created: 2026-06-27
## Date Updated: 2026-06-27
# Collaboration Summary: Issues #17, #19, #20

## Issue #17 — Practice Collaboration 1

**Goal:** Get set up with GitHub and make a first contribution to Demo-Repo using R. 

**Steps taken:**
- Downloaded GitHub Desktop and created a GitHub account
- Cloned the Demo-Repo to my local machine and switched to branch `17-practice-collaboration`
- Created `practice.R` in the `scripts/` directory
- Read in two CSV files, `penguin_species.csv` and `penguin_measurements.csv`
- Joined the two files bases on variable 
- Filtered and created a new data frames `island_body_mass` using correct parameters. 
- Ran `practice-test.R` to confirm all tests passed
- Submitted my first pull request

**Rabbit holes:** I went down a rabbit hole trying to figure out how to use `group_by()` with the right variables, I had to learn how to use `.groups = "drop"` at the end to ungroup the result so the tests would pass.

**New skills learned:** Cloning a repo, switching branches, `left_join()`, `filter()`, `group_by()` + `summarise()`, running R tests, and the full PR workflow. I think that most valuable skills from this issue are going to be the `filter()` and `group_by()` commands because they help me easily filter and arrange data in the way that I need. 

---

### Issue #19 — Practice Collaboration 2

**Goal:** Write R code to produce two summary data frames: `island_body_mass` and `adelie_body_mass`.

**Steps taken:**
- Pulled branch `19-practice-collaboration-2` using GitHub Desktop
- Changed `practice.R` to group `joined_data` by island for `island_body_mass` and filter for Adelie penguins for `adelie_body_mass`
- Updated `practice-test.R` to change `island_body_mass` tests and add new test checks for `adelie_body_mass`
- Used pipe-based (`%>%`) R code for the first time
- Fixed working directory issues (was set to `scripts/` instead of repo root)

**Rabbit holes:** I went down the rabbit hole of trying to figure out why my code wasn't matching the test. It ended up just being a typo but it was good to learn how tests work and communicate with you to ask questions. 

**New skills learned:** `%>%` pipe syntax, `group_by` + `summarise` workflows, and writing and running R tests. I think the most valuable skill from this issue is the practice that I did with pipes to make my code more clear for the furture. 

---

### Issue #20 — Practice Collaboration 3

**Goal:** Build 5 exploratory ggplot2 figures, save them as PNGs, and document them in an R Markdown README.

**Steps taken:**
- Created `exploratory_plots.R` with 5 figures: point plot, bar chart, faceted scatter plot, violin plot, and a patchwork combination
- Used `facet_wrap(~island)`, `scale_fill_manual()`, `scale_color_manual()`, and `patchwork` with `plot_annotation()` and `theme_minimal()` to make plots visually appealing and better to view. 
- Saved all 5 plots as PNGs in `analyses/exploratory_plots/figs/` using `ggsave()`
- Wrote `exploratory_plots_figs_readme.Rmd` documenting each figure with code and written descriptions
- Knitted the Rmd to PDF, resolved a working directory issue by using full file paths in `read.csv()`

**Rabbit holes:** I went down the rabbit hole of trying to figure out where repo root was, because as I was trying to knit it couldn't find the root. I ujust switching the code to the full file path. 

**New skills learned:** `ggsave()`, `patchwork`, `facet_wrap()`, R Markdown knitting to PDF, and organizing outputs into subfolders within a repo.  I think the most important skills I learned was how to make a clean document uisng r-markdown and just generally learning all of the graphing functions to properly display data. 

---

### Collaboration Feedback

**What worked well:**
- Your issue descriptions were clear and broken into specific tasks with expected outputs, which made it easy to know what to do when first starting out.
- The PR review process with comments and requested changes was a great way to learn how someone with more experience thinks and learn about new areas of code. 
- Getting feedback directly on GitHub kept everything organized in one place

**What could be improved:**
- I think that maybe the last two issues could have been combined into one to streamline the process. For example make these tables and then graph them or something. 
- This is just extra but I think that specific practice using pipes would be helpful because I think it cleans the code up a lot and is very useful to understand right away
 