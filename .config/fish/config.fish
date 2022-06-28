if status is-interactive
    # Commands to run in interactive sessions can go here
end

if test -e ~/.local/bin/powerline-shell
    function fish_prompt
        ~/.local/bin/powerline-shell --shell bare $status
    end
end

