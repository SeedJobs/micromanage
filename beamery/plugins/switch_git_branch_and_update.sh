#!/usr/bin/env bash

# Load the main plugins "interface"
source "${HOME}/.beamery/beamery/pluginsInterface.sh"

# switch_git_branch_and_update
# Switch the branches of .git repos into a specific branch and update from the latest remote origin
# The command accepts two optional argument which is the new branch to checkout
    # If no argument was passed then the command will default and switch all repos to master
    # If a second argument is passed then it will from that remote, if not it will default to origin
    # Default paramteres: git checkout master; git pull origin master

switch_git_branch_and_update() {

	if [[ $@ == *'-s'* ]]; then
		echo "This function is not designed to work in single folder mode .. please revert to good old fashioned commands"
	else
	    # if a second parameter is defined as a remote it will be used, if not then it will pull from origin
	    REMOTE=${1:-origin}
	    BRANCH=${2:-master}

	    printf "${RED}Please note that this will stash any changes made in the repos and flip the current branch${NC}\n"
	    read -p "Are you sure you want to proceed? [Y/N] " -n 1;
	    echo ""

	    if [[ $REPLY =~ ^[Yy]$ ]]; then
	        if ! [[ $BRANCH =~ ^(master|development)$ ]]; then
	            printf "\nYou are switching to a non-default branch ... will fetch repositories first\n"
	            # Since this function already accepts params passed
	            # We need to check if any of the params passed is the -s which indicates this should run on a single folder
				execute -g "echo ''; git fetch; git branch | grep -w $BRANCH > /dev/null && git stash && git checkout $BRANCH && git pull $REMOTE $BRANCH || echo 'This branch does not exist in this repo'; echo''"
	        else
				execute -g "echo ''; git branch | grep -w $BRANCH > /dev/null && git stash && git checkout $BRANCH && git pull $REMOTE $BRANCH || echo 'This branch does not exist in this repo'; echo''"
	        fi
	    fi;
	fi;
}
