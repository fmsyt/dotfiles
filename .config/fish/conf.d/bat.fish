if command -v bat >/dev/null 2>&1
    and bat --completion fish >/dev/null 2>&1
    eval (bat --completion fish)
end

if command -v batcat >/dev/null 2>&1
    and batcat --completion fish >/dev/null 2>&1
    eval (batcat --completion fish)
end
