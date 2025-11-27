#!/bin/sh

DOTFILES_DIR="$(cd "$(dirname "${0}")" && pwd -P)"

revert() {

  dotdir="$1"
  dotname=$(basename "$dotdir")

  # is not symbolic link
  if [ ! -L "$HOME/$dotname" ]; then
    return
  fi

  unlink "$HOME/$dotname"
  cp -r "$DOTFILES_DIR/$dotname" "$HOME/$dotname"
}

main() {

  # for dotdir in $DOTFILES_DIR/.??*; do
  find "$DOTFILES_DIR" -maxdepth 1 -mindepth 1 -name ".*" | while read -r dotdir; do
    dotname=$(basename "$dotdir")
    case "$dotname" in
    .git*) continue ;;
    esac

    revert "$dotdir"
  done

  git config --global --unset include.path

  printf "\e[1;36mUninstall completed.\e[m"
}

main
