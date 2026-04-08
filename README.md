# My First Repo:

## Terminal Steps for Creating and connecting a Repository:
-    You will have to do these steps for EVERY new project you wish to push to github
1.   Open the terminal and make sure it is in the correct directory - `pwd`
2.   Initialize repo, tell gitbash to track. Creates repo ONLY on local.
    -   Terminal Command: `git init` <- git initialize
3.  Create the online repo to connect with. Go to github.com --> click `new repo`
4.  Give it a name and hit `Create Repository`
5.  Copy `git remote add origin` command and paste in vsc terminal and hit enter
    -   this commmand links your local repo to the remote destination
    -   check this by running the command `git remote -v` shows a remote destination if you have one
## Steps to make and commit a new version of your project:
1.  `git add .` - add all files in this directory to a new project version. 
    -   ** This does not commit, it just stages changes, these changes can still be over written**
2.  `git commit -m "commit message"` - this command makes a commit and gives it a message

## Vocab:
-   `commit` - to save a version, you can commit locally, push commit to git hub.


