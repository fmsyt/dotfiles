#!/bin/sh

DOTFILES_DIR="$(cd "$(dirname "${0}")" && pwd -P)"
BACKUP_DIR="$HOME/.dotbackup"

revert() {

    dotdir="$1"
    dotname=$(basename "$dotdir")

    case "$dotname" in
        .git*) continue ;;
    esac

    # is not symbolic link
    if [ ! -L "$HOME/$dotname" ]; then
        return
    fi

    unlink "$HOME/$dotname"
    cp -r "$DOTFILES_DIR/$dotname" "$HOME/$dotname"
}


main() {

    for dotdir in $DOTFILES_DIR/.??*; do

        dotname=$(basename "$dotdir")
        case "$dotname" in
            .git*) continue ;;
        esac

        revert "$dotdir"
    done

    for dotdir in $DOTFILES_DIR/secrets/.??*; do

        dotname=$(basename "$dotdir")
        case "$dotname" in
            .git*) continue ;;
        esac

        revert "$dotdir"
    done

    git config --global --unset include.path
    echo "\e[1;36mUninstall completed.\e[m"
}

main
