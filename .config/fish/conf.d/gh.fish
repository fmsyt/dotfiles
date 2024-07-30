# if gh command is not found, exit
if not type gh > /dev/null
    return
end

eval (gh completion -s fish)
