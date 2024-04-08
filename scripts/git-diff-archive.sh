#!/usr/bin/env bash

set -e

color_red="\033[0;31m"
color_purple="\033[0;35m"
color_reset="\033[0m"

error_color=$color_red
verbose_color=$color_purple

verbose=0
dry_run=0
force=0

export_dir=$(pwd)

git_root=$(git rev-parse --show-toplevel)
if [ -z "$git_root" ]; then
    echo -e "${error_color}Not in a git repository${color_reset}"
    exit 1
fi

current_branch=$(git rev-parse --abbrev-ref HEAD)
target_branch="origin/master"

function usage {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -b|--branch     Target branch (default: origin/master)"
    echo "  -f|--force      Force overwrite of existing files"
    echo "  -o|--output     Output directory (default: current directory)"
    echo "  -v|--verbose    Verbose output"
    echo "  -h|--help       Display this help message"
    echo "  --dry-run       Dry run"
    exit 1
}

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -b|--branch)
            target_branch="$2"
            shift
            shift
            ;;
        -o|--output)
            export_dir=$(realpath "$2")
            shift
            shift
            ;;
        -f|--force)
            force=1
            shift
            ;;
        -v|--verbose)
            verbose=1
            shift
            ;;
        -h|--help)
            usage
            ;;
        --dry-run)
            dry_run=1
            shift
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

current_commit_id=$(git rev-parse HEAD)
target_commit_id=$(git rev-parse $target_branch)

if [ "$current_commit_id" == "$target_commit_id" ]; then
    echo -e "${error_color}No changes between $current_branch and $target_branch${color_reset}"
    exit 1
fi

cd $git_root

if [ $verbose -eq 1 ]; then
    echo -e "${verbose_color}Changes between $current_branch and $target_branch${color_reset}"
    git diff --name-only $target_branch $current_branch --diff-filter=ACMR
    echo
fi

if [ $dry_run -eq 1 ]; then
    exit 0
fi

mkdir -p $export_dir
if [ $? -ne 0 ]; then
    echo -e "${error_color}Failed to create directory: $export_dir${color_reset}"
    exit 1
fi

if [ -f "${export_dir}/${current_branch}.zip" ]; then
    if [ $force -eq 0 ]; then
        read -p "Overwrite existing file? [y/N] " allow

        if [[ ! $allow =~ ^[Yy]$ ]]; then
            echo -e "${error_color}Aborted${color_reset}"
            exit 1
        fi
    fi
    rm -f "${export_dir}/${current_branch}.zip"
fi

command git diff --name-only $target_branch $current_branch --diff-filter=ACMR \
    | sed -e 's/ /\\\\\\ /g' \
    | xargs git archive ${current_branch} --format=zip --output="${export_dir}/${current_branch}.zip" > /dev/null

if [ $verbose -eq 1 ]; then
    echo -e "${verbose_color}Exported changes to:${color_reset}"
fi

echo "${export_dir}/${current_branch}.zip"

