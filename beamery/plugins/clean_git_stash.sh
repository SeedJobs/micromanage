#!/usr/bin/env bash

# Load the main plugins "interface"
source "${HOME}/.beamery/beamery/pluginsInterface.sh"

# clean_git_stash
# Clean any stashed commits

clean_git_stash() {

    printf "${RED}Please note that this will clear any stashes you have saved${NC}\n"
    read -p "Are you sure you want to proceed ? [Y/N] " -n 1;

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        execute -g $@ "echo ''; git stash clear && echo '--> done'"
    fi
    echo "";
}
