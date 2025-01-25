alias sudo='sudo -E'
alias ip='ip -color'

# don't work command -v
type bat >/dev/null 2>&1 && alias cat='bat -p --paging=never'
type batcat >/dev/null 2>&1 && alias cat='batcat -p --paging=never'

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

abbr dc 'docker compose'
abbr dce 'docker compose exec'
abbr dcu 'docker compose up -d'
abbr dcub 'docker compose up --build -d'

abbr vd 'cd'
