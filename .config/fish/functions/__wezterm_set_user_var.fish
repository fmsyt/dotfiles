# https://wezterm.org/recipes/passing-data.html
function __wezterm_set_user_var -d "Set a wezterm user variable"
    if type -q base64
        # 改行を含む可能性のある値をbase64エンコードして渡す
        set -l b64_val (echo -n $argv[2] | base64 | string collect)

        if not set -q TMUX
            # 通常の端末環境
            printf "\033]1337;SetUserVar=%s=%s\007" $argv[1] $b64_val
        else
            # tmux内部の環境
            printf "\033Ptmux;\033\033]1337;SetUserVar=%s=%s\007\033\\" $argv[1] $b64_val
        end
    end
end
