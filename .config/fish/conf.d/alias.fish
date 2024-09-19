alias sudo='sudo -E'
alias ip='ip -color'

if command -v bat >/dev/null 2>&1
    alias cat='bat -p --paging=never'
else if command -v batcat >/dev/null 2>&1
    alias cat='batcat -p --paging=never'
end

abbr g 'git'
abbr gs 'git status'
abbr gst 'git status'
abbr ga 'git add'
abbr ga. 'git add .'
abbr gc 'git commit'
abbr gp 'git push'
abbr gco 'git checkout'

abbr d 'docker'
abbr de 'docker exec -it'

if command -v docker > /dev/null 2>&1
    abbr dc 'docker compose'
    abbr dce 'docker compose exec'
    abbr dcu 'docker compose up -d'
    abbr dcub 'docker compose up --build -d'
end
