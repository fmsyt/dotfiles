if [ -z $SSH_TTY ]; then
    alias cmd.exe=$(wslpath "C:\Windows\System32\cmd.exe")
    alias powershell.exe=$(wslpath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe")
    alias pwsh.exe=$(wslpath "C:\Users\motsuni\AppData\Local\Microsoft\WindowsApps\pwsh.exe")
fi


open() {
    script_path="$DOTFILES_DIR/scripts/open.sh"
    if [ ! -f "$script_path" ]; then
        echo "open: $script_path: No such file or directory" >&2
        return 1
    fi

    command bash "$script_path" "$@"
    return $?
}
