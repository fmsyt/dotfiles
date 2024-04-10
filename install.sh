#!/bin/sh
set -ue

helpmsg() {
    echo "Usage: $0 [--help | -h]" >&2
    echo ""
}

shopt -s dotglob

DOTFILES_DIR="$(cd "$(dirname "${0}")" && pwd -P)"
BACKUP_DIR="$HOME/.dotbackup"

cpdir() {

    # e.g.) $HOME/.local
    src="$1"
    # e.g.) $HOME/dotfiles/.local
    dst="$2"

    # e.g.) .local
    src_basename=$(basename "$src")

    tmp_dir=$(mktemp -d)

    # 1. dst を tmp に移動
    mv "$dst" "$tmp_dir"

    # 2. src を dst にコピー
    cp -r "$src" "$dst"

    # 3. tmp の中身を、1つずつ dst に移動
    find "$tmp_dir/$src_basename" -type f -printf '%P\n' | while IFS= read -r file; do

        file_dir=$(dirname "$file")

        # 3-1 dst に同名ファイルが存在する場合、バックアップ
        if [ -f "$dst/$file" ]; then
            mkdir -p "$BACKUP_DIR/$src_basename/$file_dir"
            cp "$dst/$file" "$BACKUP_DIR/$src_basename/$file"
        fi

        # 3-2 ディレクトリを作成してファイルをコピー
        mkdir -p "$dst/$file_dir"
        cp "$tmp_dir/$src_basename/$file" "$dst/$file"

    done

    # 4. tmp を削除
    rm -rf "$tmp_dir"
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
        cpdir "$HOME/$dotname" "$dotdir"
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

linkfiles
