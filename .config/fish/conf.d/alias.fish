alias sudo='sudo -E'
alias ip='ip -color'

# don't work command -v
type bat >/dev/null 2>&1 && alias cat='bat -pp'
type batcat >/dev/null 2>&1 && alias cat='batcat -pp'

abbr g git
abbr gs 'git status'
abbr gst 'git status'
abbr ga 'git add'
abbr ga. 'git add .'
abbr --set-cursor=! gcm 'git commit -m "!"'
abbr gc 'git commit'
abbr gp 'git push'
abbr gco 'git checkout'

abbr lg lazygit

abbr d docker
abbr de 'docker exec -it'

abbr dc 'docker compose'
abbr dce 'docker compose exec'
abbr dcu 'docker compose up -d'
abbr dcub 'docker compose up --build -d'

abbr ff 'find . -type f'
for x in (seq 5)
    abbr ff$x "find . -maxdepth $x -type f"
end

for x in (seq 5)
    abbr .$x "awk '{print \$$x}'"
end
