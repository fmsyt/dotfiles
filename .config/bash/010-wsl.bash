if [ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    return;
fi

if [ -z $SSH_TTY ]; then
    alias cmd.exe=$(wslpath "C:\Windows\System32\cmd.exe")
    alias powershell.exe=$(wslpath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe")
    alias pwsh.exe=$(wslpath "C:\Users\motsuni\AppData\Local\Microsoft\WindowsApps\pwsh.exe")
fi


function open() {

    help_message="Usage: open [options] [file] [...args]
Options:
    -h | --help      Print this help message
    -a <name>        Application name to open file or directory
    --args           Args to append on call"

    # オプションの処理
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                echo "$help_message"
                return 0
                ;;
            -a)
                app_name="$2"
                shift 2
                ;;
            --args)
                args="${@:2}"
                break
                ;;
            *)
                break
                ;;
        esac
    done

    if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
        full_path="$(realpath "${1:-.}")"
        win_path="$(wslpath -w "$full_path")"

        powershell.exe -Command "Invoke-Item $win_path $args" 2> /dev/null

        return $?
    else
        command open "$@"
    fi
}
