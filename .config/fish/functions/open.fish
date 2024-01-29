function open

    # `Mac OS`の`open`コマンドについて: https://oversleptabit.com/archives/4863
    # 引数の解析: argparse:  https://qiita.com/ryotako/items/e36114ec1f86dbdd274a
    argparse 'h/help' 'a=' 'args=' -- $argv
    or return 1

    if set -lq _flag_help
        echo "Usage: open [options] [file] [...args]"
        echo ""
        echo "Options:"
        echo "    -h | --help      Print this help message"
        echo "    -a <name>        Application name to open file or directory"
        echo ""
        echo "    --args           Args to append on call"
        echo ""

        return
    end


    set -lq _flag_args

    if test -n "$WSL_DISTRO_NAME"
        and test -z $SSH_TTY

        set -lq _flag_a

        if test -n "$_flag_a"
            set -l app_name $_flag_a
            powershell.exe -Command Invoke-Expression $app_name $argv[2..-1] $_flag_args 2> /dev/null

        else
            set -l full_path (realpath $argv[1])
            set -l win_path (wslpath -w $full_path)

            powershell.exe -Command Invoke-Item $win_path $argv[2..-1] $_flag_args 2> /dev/null
        end

        return $status

    else if type -q xdg-open
        command xdg-open $argv
    else
        command open $argv $_flag_args
    end
end
