#!/bin/sh
set -ue

verbose=0

orange="\033[0;33m"
reset="\033[0m"

verbose_prefix="$orange[VERBOSE]$reset"

helpmsg() {
    echo "Usage: $0"
    echo "Options:"
    echo "  -d, --debug     Print debug information"
    echo "  -h, --help      Print this message"
    echo "  -v, --verbose   Print verbose information"
}

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
    if [ $verbose -eq 1 ]; then
        echo "$verbose_prefix Existed files are moved to $tmp_dir"
    fi
    mv "$dst" "$tmp_dir"

    # 2. src を dst にコピー
    if [ $verbose -eq 1 ]; then
        echo "$verbose_prefix Copying $src to $dst"
    fi
    cp -r "$src" "$dst"

    # 3. tmp の中身を、1つずつ dst に移動
    find "$tmp_dir/$src_basename" -type f,l -printf '%P\n' | while IFS= read -r file; do

        file_dir=$(dirname "$file")

        # 3-1 dst に同名ファイルが存在する場合、バックアップ
        if [ -f "$dst/$file" ]; then

            if [ $verbose -eq 1 ]; then
                echo "$verbose_prefix Backup $dst/$file"
            fi

            mkdir -p "$BACKUP_DIR/$src_basename/$file_dir"
            cp "$dst/$file" "$BACKUP_DIR/$src_basename/$file"
        fi

        # 3-2 ディレクトリを作成してファイルをコピー
        if [ $verbose -eq 1 ]; then
            echo "$verbose_prefix Copy $tmp_dir/$src_basename/$file to $dst/$file"
        fi
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

        if [ $verbose -eq 1 ]; then
            echo "$verbose_prefix dotdir: $dotdir"
        fi

        syncfiles "$dotdir"
    done

    for dotdir in $DOTFILES_DIR/secrets/.??*; do

        dotname=$(basename "$dotdir")
        case "$dotname" in
            .git*) continue ;;
        esac

        if [ $verbose -eq 1 ]; then
            echo "$verbose_prefix dotdir: $dotdir"
        fi

        syncfiles "$dotdir"
    done

}

post_ssh_install() {

    SSH_CONFIG_DIR="$HOME/.ssh/shared"
    SSH_INCLUDE_DIRECTIVE="Include $SSH_CONFIG_DIR/*.conf"
    SSH_CONFIG_FILE="$HOME/.ssh/config"

    if [ -f $SSH_CONFIG_FILE ]; then
        if grep -F -q "$SSH_INCLUDE_DIRECTIVE" $SSH_CONFIG_FILE; then
            echo "SSH config already includes shared config. Skipping..."
        else
            echo "Adding shared SSH config include directive..."

            # Add first line to the file
            sed -i "1s;^;$SSH_INCLUDE_DIRECTIVE\n;" $SSH_CONFIG_FILE

        fi
    else
        echo "Creating SSH config file..."
        echo $SSH_INCLUDE_DIRECTIVE > $SSH_CONFIG_FILE
    fi

    chmod 600 $SSH_CONFIG_FILE
}

post_install() {
    post_ssh_install

    git config --global include.path "$DOTFILES_DIR/.gitconfig"

    if [ -z "$(ls -A $BACKUP_DIR)" ]; then
        rmdir $BACKUP_DIR
    else
        echo "Current dotfiles are evacuated to $BACKUP_DIR"
    fi

    echo "\e[1;36mInstall completed.\e[m"
}

do_install() {
    linkfiles
    post_install
}

while [ $# -gt 0 ]; do
    case ${1} in
        --debug|-d)
            set -uex
            shift
            ;;
        --help|-h)
            helpmsg
            exit 1
            ;;
        --verbose|-v)
            verbose=1
            shift
            ;;
        *)
            shift
            ;;
    esac
done

do_install
