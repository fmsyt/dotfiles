if [ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ]
    return;
end

if [ -z $SSH_TTY ]
    alias cmd.exe=(wslpath "C:\Windows\System32\cmd.exe")
    alias powershell.exe=(wslpath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe")
end


function get_registory
    if [ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ]
        echo "This function is run on WSL."
        exit 1;
    end

    echo (powershell.exe -c "(New-Object -ComObject WScript.Shell).RegRead('$argv[1]')" | sed s/\r//g)
end

if [ -e "~/Desktop" ]
    set p (get_registory "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders\Desktop")
    ln -s (wslpath $p) ~/
end

if [ -e "~/Documents" ]
    set p (get_registory "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders\{F42EE2D3-909F-4907-8871-4C22FC0BF756}")
    ln -s (wslpath $p) ~/
end

if [ -e "~/Downloads" ]
    set p (get_registory "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders\{7D83EE9B-2244-4E70-B1F5-5393042AF1E4}")
    ln -s (wslpath $p) ~/
end
