#!/usr/bin/env bash

export_dir=$(pwd)

git_root=$(git rev-parse --show-toplevel)
if [ -z "$git_root" ]; then
    echo "Not in a git repository"
    exit 1
fi

current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $current_branch"

target_branch="origin/master"

function usage {
    echo "Usage: $0 [-b branch]"
    echo "  -b branch   Branch to compare against (default: origin/master)"
    exit 1
}

while getopts "b:" opt; do
    case $opt in
        b)
            target_branch=$OPTARG
            ;;
        *)
            usage
            ;;
    esac
done

current_commit_id=$(git rev-parse HEAD)
target_commit_id=$(git rev-parse $target_branch)

if [ "$current_commit_id" == "$target_commit_id" ]; then
    echo "Branches are the same"
    exit 1
fi

command git diff --name-status $target_branch...$current_branch


