function open
    if test -f /proc/sys/fs/binfmt_misc/WSLInterop
        and test -z $SSH_TTY

        set -l current_path (pwd)
        set -l full_path (wslpath -w "$current_path/$argv[1]")

        if [ -f "$full_path" ]
            cmd.exe /c start $full_path 2> /dev/null
        else
            cmd.exe /c explorer $full_path 2> /dev/null
        end

        if [ $status -eq 1 ]
            return 0
        end

        return $status

    else
        command open $argv
    end
end
