#!/bin/bash

if [ $(uname) = "Darwin" ]; then
    command open $@
    exit 0
fi

if [ -n "$SSH_CONNECTION" ]; then
    command open $@
    exit 0
fi

args=$@

verbose=0

path_list=()

if [ "$#" -eq 0 ]; then
    path_list+=(".")
fi

while [ "$#" -gt 0 ]; do
    case "$1" in
        -h|--help)
            echo "Usage: open [-h]"
            echo "       open [-v] [-a <name>] [...<path|url>] [--args ...]"
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
            path_list+=("$1")
            shift
            ;;
    esac
done

if [ -n "$WSL_DISTRO_NAME" ]; then

    for path in "${path_list[@]}"; do
        win_path=$path

        has_protocol=$(echo "$path" | grep -E "^[a-zA-Z]+://")
        if [ -z "$has_protocol" ]; then
            full_path=$(realpath "$path")
            win_path=$(wslpath -w "$full_path")
        fi

        if [ -z "$app_name" ]; then
            app_name=start
        fi

        [ "$verbose" -eq 1 ] && echo "[VERBOSE] cmd.exe /u /q /c $app_name \"${win_path}\" ${args[@]}"
        cmd.exe /u /q /c $app_name "${win_path}" ${args[@]} 2> /dev/null
    done

    exit 0

elif command -v xdg-open > /dev/null; then
    command xdg-open "$args" 2> /dev/null
fi
