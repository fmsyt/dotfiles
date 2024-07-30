# if gh command is not found, exit
if not command -v gh > /dev/null 2>&1
    exit
end

eval (gh completion -s fish)
