function clip
    read input

    if test -f /proc/sys/fs/binfmt_misc/WSLInterop
        and test -z $SSH_TTY

        powershell.exe -NoProfile -NonInteractive -NoLogo -c "echo \"$input\" | Set-Clipboard"

    else
        set b64 (echo $input | base64)
        echo -ne "\033]52;c;$b64\a"
    end
end
