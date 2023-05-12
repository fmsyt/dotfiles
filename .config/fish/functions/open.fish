function open

    # `Mac OS`の`open`コマンドについて: https://oversleptabit.com/archives/4863
    # 引数の解析: argparse:  https://qiita.com/ryotako/items/e36114ec1f86dbdd274a
    argparse 'h/help' 'a=' 'args=' -- $argv
    or return 1

    if set -lq _flag_help
        echo "Usage: open [options] [file] [...args]"
        echo ""
        echo "Options:"
        echo "    -h or --help     Print this help message"
        echo "    -a <name>        Application name to open file or directory"
        echo "    --args           Args to append on call"

        return
    end


    set -lq _flag_args

    if test -f /proc/sys/fs/binfmt_misc/WSLInterop
        and test -z $SSH_TTY

        set -lq _flag_a

        set -l current_path (pwd)
        set -l full_path "$current_path/$argv[1]"
        set -l win_path (wslpath -w $full_path)

        if [ -n $_flag_a ] | [ -f "$current_path/$argv[1]" ]
            powershell.exe -Command start $_flag_a $win_path $argv[2..-1] $_flag_args 2> /dev/null
        else
            powershell.exe -Command explorer (wslpath -w $full_path) 2> /dev/null
        end

        if [ $status -eq 1 ]
            return 0
        end

        return $status

    else
        command open $argv $_flag_args
    end
end
