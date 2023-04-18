function clip
    read -z input

    if test -f /proc/sys/fs/binfmt_misc/WSLInterop
        and test -z $SSH_TTY

        # set input (echo $input | sed -E 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g')

        # 文字列を置換する
        set input (echo -n $input | sed -E 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g' | sed 's/"/""/g' | sed "s/'/''/g" | sed 's/`/``/g' | awk 'BEGIN { ORS = "`n" } { print }')

        powershell.exe -NoProfile -NonInteractive -NoLogo -c "Write-Output \"$input\" | Set-Clipboard"

    else
        set b64 (echo $input | base64)
        echo -ne "\033]52;c;$b64\a"
    end
end
