#!/bin/bash

# This file contains some really simple functions that are useful when building up customization scripts.


# Checks if the git config has a user registered - and sets it up if not.
#
# Param 1: name
# Param 2: email
#
config_user() {
    local gcn=$(git config --global user.name)
    if [ -z "${gcn}" ]; then
        echo "Setting up git user / remote"
        git config --global user.name "$1"
        git config --global user.email "$2"
        
    fi
}

# Checks if the git remote is configured - and sets it up if not. Fetches either way.
#
# Param 1: remote name
# Param 2: remote url
#
config_remote() {
    local gr=$(git remote -v | grep $1)
    if [ -z "${gr}" ]; then
        git remote add $1 $2
    fi
    git fetch $1
}

# Setup special .ssh files
#
# Param 1: bash array, filenames relative to the customization directory that should be copied to ~/.ssh
setup_ssh() {
    mkdir -p ~/.ssh
    local files=("$@")
    for file in "${files[@]}" ; do
        local cfile="/devcontainer-customization/${file}"
        local hfile="~/.ssh/${file}"
        if [ ! -f "${hfile}" ]; then
            echo "copying ${file}"
            cp "${cfile}" "${hfile}"
            chmod 600 "${hfile}"
        fi
    done
    ls ~/.ssh
}
