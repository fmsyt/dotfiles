function cat
    if type bat >/dev/null 2>&1
        command bat -p $argv
    else
        command cat $argv
    end
end
