function clip
    read input

    if test -f /proc/sys/fs/binfmt_misc/WSLInterop
        and test -z $SSH_TTY

        set i (string replace -r -a '"' '\"\"' $input)
        powershell.exe -NoProfile -NonInteractive -NoLogo -c "echo \"$i\" | Set-Clipboard"

    else
        set b64 (echo $input | base64)
        echo -ne "\033]52;c;$b64\a"
    end
end
