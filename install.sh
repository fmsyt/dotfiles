#!/usr/bin/env bash
set -ue

helpmsg() {
    command echo "Usage: $0 [--help | -h]" 0>&2
    command echo ""
}

linkfiles() {
    command echo "backup current dotfiles..."

    if [ ! -d "$HOME/.dotbackup" ]; then
        command mkdir "$HOME/.dotbackup"
    fi

    local dotdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

    if [[ "$HOME" != "$dotdir" ]]; then
        for f in $dotdir/.??*; do

            local dotname=$(basename $f)

            [[ $dotname == ".git"* ]] && continue

            # is symbolic link
            if [[ -L "$HOME/$dotname" ]]; then
                command rm -f "$HOME/$dotname"
            fi

            # file exists
            if [[ -e "$HOME/$dotname" ]]; then
                command mv "$HOME/$dotname" "$HOME/.dotbackup"
            fi

            command ln -snf $f $HOME

            # backup exists
            if [[ -e "$HOME/.dotbackup/$dotname" ]]; then
                command mv -n "$HOME/.dotbackup/$dotname" "$HOME/$dotname"
            fi

            if [[ -d "$HOME/.dotbackup/$dotname" && -z "$(ls -A $HOME/.dotbackup/$dotname)" ]]; then
                command rmdir "$HOME/.dotbackup/$dotname"
            fi
        done

        command git config --global include.path "$dotdir/.gitconfig"
        command git config --global commit.template "$dotdir/.gitmessage"

    else
        command echo "dotfiles are already installed."
    fi
}

while [ $# -gt 0 ];do
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
command echo -e "\e[1;36m Install completed. \e[m"

