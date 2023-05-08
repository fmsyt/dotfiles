#!/bin/sh
set -ue

helpmsg() {
    echo "Usage: $0 [--help | -h]" >&2
    echo ""
}

linkfiles() {

    if [ ! -d "$HOME/.dotbackup" ]; then
        mkdir "$HOME/.dotbackup"
    fi

    dotdir="$(cd "$(dirname "${0}")" && pwd -P)"

    if [ "$HOME" != "$dotdir" ]; then
        for f in $dotdir/.??*; do

            dotname=$(basename "$f")

            case "$dotname" in
                .git*) continue ;;
            esac

            # is symbolic link
            if [ -L "$HOME/$dotname" ]; then
                unlink "$HOME/$dotname"
            fi

            # file exists
            if [ -e "$HOME/$dotname" ]; then
                mv "$HOME/$dotname" "$HOME/.dotbackup"
            fi

            ln -snf "$f" "$HOME"

            # backup exists
            if [ -e "$HOME/.dotbackup/$dotname" ]; then
                mv -n "$HOME/.dotbackup/$dotname/*" "$HOME/$dotname/"
            fi

            if [ -d "$HOME/.dotbackup/$dotname" ] && [ -z "$(ls -A $HOME/.dotbackup/$dotname)" ]; then
                rmdir "$HOME/.dotbackup/$dotname"
            fi
        done

        git config --global include.path "$dotdir/.gitconfig"

        if [ -z "$(ls -A $HOME/.dotbackup)" ]; then
            rmdir $HOME/.dotbackup
        else
            echo "Current dotfiles are evacuated to $HOME/.dotbackup"
        fi

        echo -e "\e[1;36mInstall completed.\e[m"

    else
        echo "dotfiles are already installed."
    fi
}

while [ $# -gt 0 ]; do
    case ${1} in
        --debug|-d)
            set -uex
            ;;
        --help|-h)
            helpmsg
            exit 1
            ;;
        *)
            ;;
    esac
    shift
done

linkfiles
