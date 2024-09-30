
# GitHub Resources
## How to clone
https://docs.github.com/en/desktop/adding-and-cloning-repositories/cloning-a-repository-from-github-to-github-desktop
- Go to your repo on GitHub web browser.
- Click the green `<> code` button. 
- Click `Open with GitHub Desktop`.
- Choose where you want to save the repo on your computer. 
- Click `Clone`.
## How to pull, commit, push
https://docs.github.com/en/desktop/making-changes-in-a-branch/committing-and-reviewing-changes-to-your-project-in-github-desktop
- Before you start working, open GitHub Desktop. 
- Click `Fetch origin`. If that button changes to `Pull`, also click that. 
- Make the changes to your files and scripts. 
- Return to GitHub Desktop. 
- Click `Fetch` again to pull in any changes that may have been made while you were working on your files. 
- Write your commit message in the `Summary` box and add any additional text to the `Description`. If you only want to commit a portion of your changes, use the check boxes to select the files/lines you want to commit. 
- Click the blue `Commit` button in the bottom left corner. This will commit your changes to the git system on your local machine. 
- Click `Push origin` (the button that usually says `Fetch`) to push your changes to GitHub so everyone has access to them.
## How to create a new branch
https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-and-deleting-branches-within-your-repository
- On GitHub web browser, select the branch drop down menu.
- Write in the name of your new branch in the `Find or create a branch...` field. Use underscores or dashes instead of spaces. 
- Click `Create` to create the branch. 
- Open GitHub Desktop and `Fetch`/`Pull`.
- Under the branch drop down, select your new branch. 
- Make changes and pull/commit/push as usual. 
## How to access and older version of a file
https://docs.github.com/en/pull-requests/committing-changes-to-your-project/viewing-and-comparing-commits/differences-between-commit-views  
There are 2 main ways to find your commit history:  
1. Via file - use this if you are looking for the history from a specific file  
  - On GitHub web browser, locate the file of interest.
  - Click the button that has a little timer on it and says `History`. 
  - Locate the commit you want to look at.
  - Click the icon second from the right that has a little dog-eared page and <> to view what the file looked like at that point in time.  
2. Via commits - use this if you are looking for the history from the entire repository  
  - On GitHub web browser, click the button that has a little timer on it that says `## Commits`.
  - Locate the commit you want to look at.
  - You can click the commit message to see the changes that were made in that commit. Or you can click `<>` to view the what the entire repository looked like at that point in time.
## How to submit a pull request
https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request?tool=webui  
https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/requesting-a-pull-request-review  
**What is a pull request and why is it called that?** A pull request is a proposal to merge your changes from one branch to another. Rather than you "pushing" changes from your branch to another branch (usually main), you are asking (requesting) that main "pull" changes from your branch into main. This nuance emphasizes that it is the repository maintainer's responsibility to decide whether or not to integrate the changes - hence the reason you are "requesting".
- On GitHub web browser, go to the `Pull requests` tab.
- Click on the green `New pull request` button.
- In the grey banner, there are 2 drop downs. For `base:`, select where you want your files to merge into (usually "main"). In `compare:`, select the branch that has your changes that you want to merge. 
- Click "Create pull request".
## How to review and accept a pull request
https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/reviewing-proposed-changes-in-a-pull-request  
https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/merging-a-pull-request  
- On GitHub web browser, go to the `Pull requests` tab.
- In the list of open pull requests, click on the one you want to review. 
- Review the code by looking at the `Files changed` tab. 
- If everything looks good, you can proceed with merging the pull request. 
	- Note that if you would like to leave comments or suggest additional changes, we can discuss how to do this using GitHub's tools at a future date. For the time being, if you have comments or revisions, notify the person who submitted the pull request over Teams chat. 
- Return to the `Conservation` tab and click the green `Merge pull request` button. If you don't see this button, it is likely because there are merge conflicts that still need to be resolved. After you resolve those conflicts, you should be able to return here and merge the pull request. 
- GitHub will ask you to confirm the merge. You can add a short message to describe what's being merged. Click the `Confirm merge` button. 
- If the branch is no longer needed, you can delete the branch associated with the pull request. GitHub will often show a button to `Delete branch`. 
- After you delete the branch, notify everyone on the team. Everyone (including you) should return to GitHub Desktop and delete the branch. 
