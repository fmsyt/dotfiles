# if gh command is not found, exit
if not type gh 2&>1 > /dev/null
    exit
end

eval (gh completion -s fish)
