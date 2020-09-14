#!/bin/bash

#Sets the branch to your current branch.
branch=$(git symbolic-ref --short HEAD)
#Displays remotes, fetches all branches and then pulls from the upstream remote into the branch you are currently on
git remote -v && git fetch --all && git pull upstream $branch
