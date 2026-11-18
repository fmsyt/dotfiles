function clip --description 'Copy a file or standard input via OSC 52'
    argparse 'h/help' -- $argv
    or return

    if set -q _flag_help
        printf '%s\n' \
            'Usage: clip [FILE]' \
            '       COMMAND | clip' \
            '' \
            'Copy FILE, or standard input when FILE is omitted or is -, to the' \
            'terminal clipboard using OSC 52.'
        return 0
    end

    if test (count $argv) -gt 1
        echo 'clip: expected at most one file' >&2
        return 2
    end

    set -l encoded
    if test (count $argv) -eq 1; and test "$argv[1]" != '-'
        if not test -f "$argv[1]"; or not test -r "$argv[1]"
            printf 'clip: cannot read file: %s\n' "$argv[1]" >&2
            return 1
        end
        command base64 <"$argv[1]" | command tr -d '\n' | read -z encoded
    else
        command base64 | command tr -d '\n' | read -z encoded
    end

    # tmux requires escape sequences to be wrapped in a DCS passthrough.
    if set -q TMUX
        printf '\ePtmux;\e\e]52;c;%s\a\e\\' "$encoded"
    else
        printf '\e]52;c;%s\a' "$encoded"
    end
end
