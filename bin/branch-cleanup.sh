#!/usr/bin/env bash

# Determine initial branch
initial_branch=$(export BRANCH=$(git branch | grep "*" | awk "{ print \$2 }") && echo $BRANCH)

# Switch to 'main'
[[ $initial_branch != "main" ]] && echo "Branch: $initial_branch"

# This must be run from main
git checkout main 2> /dev/null || ERROR=true

[[ $ERROR ]] && echo "Exiting" && exit 1

# Update our list of remotes
echo -en "Fetching and pruning origin: "
git fetch
git remote prune origin
echo "OK"

# Remove local fully merged branches
echo -en "Removing merged local branches: "
git branch --merged main | grep -v 'main$' | xargs git branch -d
echo "OK"


# Show remote fully merged branches
ignore_branches="sandbox$|dev$|test$|uat$|qa$|stage$"
merged_branches=$(git branch -r --merged main | sed 's/ *origin\///' | grep -v 'main$' | grep -vEi ${ignore_branches} )
if [[ ! -z $merged_branches ]]; then
    echo "The following remote branches are fully merged and will be removed:"
    echo -e "$merged_branches"
    read -p "Continue (y/n)? "

    if [[ "$REPLY" == "y" ]]; then
       # Remove remote fully merged branches
       for merged_branch in $merged_branches
       do
           echo "removing branch: $merged_branch"
           echo $merged_branch | xargs -I% git push origin :%
       done
    fi
fi

# Return to initial branch
[[ $initial_branch != "main" ]] && git checkout $initial_branch &> /dev/null
current_branch=$(git branch --show-current)
[[ $current_branch != $initial_branch ]] && echo -e "Switched to branch: $current_branch"

echo "Cleanup complete"
