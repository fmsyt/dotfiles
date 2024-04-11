#!/bin/sh

open() {
    script_path="$HOME/.config/sh/scripts/open.sh"
    if [ ! -f "$script_path" ]; then
        echo "open: $script_path: No such file or directory" >&2
        return 1
    fi

    command bash "$script_path" "$@"
    return $?
}
