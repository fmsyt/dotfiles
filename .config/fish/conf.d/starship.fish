if not command -v starship > /dev/null 2>&1
    exit
end

starship init fish | source
eval (starship completions fish)
