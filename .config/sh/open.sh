#!/bin/sh

open() {
    dotfiles_dir=$(dirname $(readlink "$HOME/.config"))
    script_path="$dotfiles_dir/scripts/linux/utils/open.sh"
    if [ ! -f "$script_path" ]; then
        echo "open: $script_path: No such file or directory" >&2
        return 1
    fi

    command bash "$script_path" "$@"
    return $?
}
