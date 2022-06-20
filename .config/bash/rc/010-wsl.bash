if [ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    return;
fi

if [ -z $SSH_TTY ]; then
    alias explorer='explorer.exe'
else
    alias cmd.exe='/mnt/c/Windows/System32/cmd.exe'
    alias powershell.exe='/mnt/c/Program\ Files/PowerShell/7/pwsh.exe'
fi

