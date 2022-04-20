if [ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    return;
fi

if [ -z $SSH_TTY ]; then
    alias explorer='explorer.exe'
    alias cmd\.exe='/mnt/c/Windows/System32/cmd.exe'
fi

