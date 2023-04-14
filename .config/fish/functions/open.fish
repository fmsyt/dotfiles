function open
    if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]
        set -l current_path $(pwd)
        cmd.exe /c start $(wslpath -w "$current_path/$argv[1]") 2> /dev/null
    else
        command open $argv
    end
end
