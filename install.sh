#!/bin/sh
set -ue

helpmsg() {
    echo "Usage: $0 [--help | -h]" >&2
    echo ""
}

DOTFILES_DIR="$(cd "$(dirname "${0}")" && pwd -P)"
BACKUP_DIR="$HOME/.dotbackup"

copyfiles() {

    src="$1"
    dst="$2"

    src_basename=$(basename "$src")

    find "$src" -type f -printf '%P\n' | while IFS= read -r file; do

        file_dir=$(dirname "$file")

        if [ -f "$dst/$file" ]; then
            mkdir -p "$BACKUP_DIR/$src_basename/$file_dir"
            cp "$dst/$file" "$BACKUP_DIR/$src_basename/$file"
        fi

        mkdir -p "$dst/$file_dir"
        cp "$src/$file" "$dst/$file"

    done
}

syncfiles() {

    dotdir="$1"
    dotname=$(basename "$dotdir")

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

    ln -snf "$dotdir" "$HOME/$dotname"
}

linkfiles() {

    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir "$BACKUP_DIR"
    fi

    if [ "$HOME" = "$DOTFILES_DIR" ]; then
        echo "dotfiles are already installed."
        exit 1
    fi

    for dotdir in $DOTFILES_DIR/.??*; do

        dotname=$(basename "$dotdir")
        case "$dotname" in
            .git*) continue ;;
        esac

        syncfiles "$dotdir"
    done

    for dotdir in $DOTFILES_DIR/secrets/.??*; do

        dotname=$(basename "$dotdir")
        case "$dotname" in
            .git*) continue ;;
        esac

        syncfiles "$dotdir"
    done

    git config --global include.path "$DOTFILES_DIR/.gitconfig"

    if [ -z "$(ls -A $BACKUP_DIR)" ]; then
        rmdir $BACKUP_DIR
    else
        echo "Current dotfiles are evacuated to $BACKUP_DIR"
    fi

    echo "\e[1;36mInstall completed.\e[m"
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

syncfiles "$DOTFILES_DIR/bin"
linkfiles
