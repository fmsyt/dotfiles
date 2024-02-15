#!/bin/bash

path="."
verbose=0

while [ "$#" -gt 0 ]; do
    case "$1" in
        -h|--help)
            echo "Usage: open [options] [file] [...args]"
            echo ""
            echo "Options:"
            echo "    -h | --help      Print this help message"
            echo "    -v | --verbose   Print verbose messages"
            echo "    -a <name>        Application name to open file or directory"
            echo ""
            echo "    --args           Args to append on call"

            exit 0
            ;;
        -a)
            shift
            app_name="$1"
            shift
            ;;
        -v|--verbose)
            verbose=1
            shift
            ;;
        --args)
            shift
            args=("${@:1}")
            break
            ;;
        *)
            path="$1"
            shift
            ;;
    esac
done


if [ -n "$SSH_CONNECTION" ]; then
    echo "Error: Cannot open file or directory from SSH connection"
    exit 1
fi


if [ "$verbose" -eq 1 ]; then
    echo "[VERBOSE] path: $path"
    echo "[VERBOSE] app: $app_name"
    echo "[VERBOSE] args: ${args[@]}"
fi



if [ -n "$WSL_DISTRO_NAME" ]; then

    win_path=$path

    has_protocol=$(echo "$path" | grep -E "^[a-zA-Z]+://")
    if [ -z "$has_protocol" ]; then
        full_path=$(realpath "$path")
        win_path=$(wslpath -w "$full_path")
    fi


    if [ -z "$app_name" ]; then
        app_name=start
    fi

    [ "$verbose" -eq 1 ] && echo "[VERBOSE] cmd.exe /q /c $app_name \"${win_path}\" ${args[@]}"
    cmd.exe /q /c $app_name "${win_path}" ${args[@]} 2> /dev/null

elif command -v xdg-open >/dev/null; then
    xdg-open $@
else
    command open $@
fi
