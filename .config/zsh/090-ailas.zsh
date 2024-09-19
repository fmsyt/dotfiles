alias sudo='sudo -E'
alias ip='ip -color'

if command -v bat > /dev/null 2>&1; then
    alias cat='bat -p --paging=never'
elif command -v batcat > /dev/null 2>&1; then
    alias cat='batcat -p --paging=never'
fi

if command -v abbr > /dev/null 2>&1; then
    abbr --session g='git' > /dev/null 2>&1
    abbr --session gs='git status' > /dev/null 2>&1
    abbr --session gst='git status' > /dev/null 2>&1
    abbr --session ga='git add' > /dev/null 2>&1
    abbr --session gc='git commit' > /dev/null 2>&1
    abbr --session gp='git push' > /dev/null 2>&1
    abbr --session gco='git checkout' > /dev/null 2>&1
    abbr --session d='docker' > /dev/null 2>&1
    abbr --session de='docker exec -it' > /dev/null 2>&1
    abbr --session dc='docker compose' > /dev/null 2>&1
    abbr --session dce='docker compose exec' > /dev/null 2>&1
    abbr --session dcu='docker compose up -d' > /dev/null 2>&1
    abbr --session dcub='docker compose up --build -d' > /dev/null 2>&1
fi
