function tmux-attach
    if test -n "$TMUX"
        echo "Already inside a tmux session."
        return
    end

    set -l session $argv[1]

    if test -z "$session"
        set session (command tmux list-sessions -F '#S' | command fzf --print-query --prompt="Select a tmux session: " | head -n 1)
    end

    if test -z "$session"
        echo "No session selected."
        return
    end

    if command tmux has-session -t "$session" 2>/dev/null
        tmux attach-session -t "$session"
    else
        tmux new-session -s "$session"
    end
end
