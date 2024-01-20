#!/bin/sh
set -ue

helpmsg() {
    echo "Usage: $0 [--help | -h]" >&2
    echo ""
}

BACKUP_DIR="$HOME/.dotbackup"

copyfiles() {

    src=$1
    dst=$2

    for file in $(find $src -type f -printf '%P\n'); do

        if [ -f $dst/$file ]; then
            mkdir -p $BACKUP_DIR/$(dirname $file)
            cp $dst/$file $BACKUP_DIR/$file
        fi

        mkdir -p $dst/$(dirname $file)
        cp $src/$file $dst/$file

    done
}

linkfiles() {

    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir "$BACKUP_DIR"
    fi

    dotdir="$(cd "$(dirname "${0}")" && pwd -P)"

    if [ "$HOME" = "$dotdir" ]; then
        echo "dotfiles are already installed."
        exit 1
    fi

    for f in $dotdir/.??*; do

        dotname=$(basename "$f")

        case "$dotname" in
            .git*) continue ;;
        esac

        # is symbolic link
        if [ -L "$HOME/$dotname" ]; then
            unlink "$HOME/$dotname"

        # is directory
        elif [ -d "$HOME/$dotname" ]; then
            copyfiles "$HOME/$dotname" "$dotdir"
            rm -rf "$HOME/$dotname"

        # is file
        elif [ -f "$HOME/$dotname" ]; then
            mkdir -p "$BACKUP_DIR"
            mv "$HOME/$dotname" "$BACKUP_DIR"
        fi

        ln -snf "$f" "$HOME"

    done

    git config --global include.path "$dotdir/.gitconfig"

    if [ -z "$(ls -A $BACKUP_DIR)" ]; then
        rmdir $BACKUP_DIR
    else
        echo "Current dotfiles are evacuated to $BACKUP_DIR"
    fi

    echo -e "\e[1;36mInstall completed.\e[m"
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
