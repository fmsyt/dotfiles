function open

    # `Mac OS`の`open`コマンドについて: https://oversleptabit.com/archives/4863
    # 引数の解析: argparse:  https://qiita.com/ryotako/items/e36114ec1f86dbdd274a

    argparse -n sugoi 'h/help' -- $argv
    or return 1

    if set -lq _flag_help
        echo "Usage: open [options] [file] [--args [...args]]"
        echo ""
        echo "Options:"
        echo "    -h or --help     Print this help message"
        echo "    -a <name>        Application name to open file or directory"

        return
    end



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
