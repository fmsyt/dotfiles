#!/bin/bash

if [ -n "$WSL_DISTRO_NAME" ] && [ -z "$SSH_TTY" ]; then

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

    if [ "$verbose" -eq 1 ]; then
        echo "[VERBOSE] path: $path"
        echo "[VERBOSE] app: $app_name"
        echo "[VERBOSE] args: ${args[@]}"
    fi

    full_path=$(realpath "$path")
    win_path=$(wslpath -w "$full_path")

    if [ -n "$app_name" ]; then
        if [ "$verbose" -eq 1 ]; then
            echo "[VERBOSE] powershell.exe -Command \"Invoke-Expression \\\"$app_name ${win_path} ${args[@]}\\\"\""
        fi

        powershell.exe -Command "Invoke-Expression \"$app_name ${win_path} ${args[@]}\"" 2> /dev/null
    else
        if [ "$verbose" -eq 1 ]; then
            echo "[VERBOSE] powershell.exe -Command Invoke-Item \"$win_path\" \"${args[@]}\""
        fi

        powershell.exe -Command Invoke-Item "$win_path" "${args[@]}" 2> /dev/null
    fi
    exit $?

elif command -v xdg-open >/dev/null; then
    xdg-open $@
else
    command open $@
fi
