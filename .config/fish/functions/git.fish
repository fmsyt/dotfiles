function git --wrap git

    set -l pwd (pwd)
    set -l current_fs (df -P "$pwd" | awk 'NR==2 {print $1}')

    if test -f /proc/sys/fs/binfmt_misc/WSLInterop
        and test $current_fs = drvfs

        set -l git_path_win (cmd.exe /c where.exe git 3> /dev/null | tr -d '\r')

        if test -n $git_path_win
            set -l git_path (wslpath -u $git_path_win)
            command $git_path $argv
        else
            command git $argv
        end

        return $status

    else
        command git $argv
    end
end
