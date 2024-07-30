if [ ! command -v gh &> /dev/null ]; then
    return
fi

if [ ! -f /etc/bash_completion ]; then
    return
fi


eval "$(gh completion -s bash)"
