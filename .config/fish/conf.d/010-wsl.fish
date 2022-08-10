if [ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ]
    exit
end

if [ -z $SSH_TTY ]
    alias explorer='explorer.exe'
else
    alias cmd.exe='/mnt/c/Windows/System32/cmd.exe'
    alias powershell.exe='/mnt/c/Program\ Files/PowerShell/7/pwsh.exe'
end
