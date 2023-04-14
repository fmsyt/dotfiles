if [ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    return;
fi

if [ -z $SSH_TTY ]; then
    alias cmd.exe='/mnt/c/Windows/System32/cmd.exe'
    alias powershell.exe='/mnt/c/Program\ Files/PowerShell/7/pwsh.exe'
fi


function open() {
    if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ] && [ -z $SSH_TTY ]; then

        local current_path=$(pwd)
        local full_path=$(wslpath -w "$current_path/$1")

        if [ -f "$full_path" ]; then
            cmd.exe /c start $full_path 2> /dev/null
        else
            cmd.exe /c explorer $full_path 2> /dev/null
        fi

        if [ $? -eq 1 ]; then
            return 0
        fi

        return $?

    else
        command open $@
    fi
}
