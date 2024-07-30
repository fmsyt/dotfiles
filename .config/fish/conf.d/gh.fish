# if gh command is not found, exit
if not type gh > /dev/null
    exit
end

eval (gh completion -s fish)
