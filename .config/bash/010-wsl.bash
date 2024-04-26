if [ ! -n "$WSL_DISTRO_NAME" ]; then
    return
fi

if [ -z $SSH_TTY ]; then
    alias cmd.exe=$(wslpath "C:\Windows\System32\cmd.exe")
    alias powershell.exe=$(wslpath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe")
    alias pwsh.exe=$(wslpath "C:\Users\motsuni\AppData\Local\Microsoft\WindowsApps\pwsh.exe")
fi
