alias sudo='sudo -E'
alias ip='ip -color'

set -l use_bat 0
set -l bat_version 0
set -l batcat_version 0

# 各桁を100倍して比較する
if bat --version >/dev/null 2>&1 # bat 0.26.0
    set bat_version (bat --version | awk '{print $2}' | awk -F. '{printf("%d%03d%03d\n", $1, $2, $3)}')
    set use_bat 1
end

if batcat --version >/dev/null 2>&1 # bat 0.24.0
    set batcat_version (batcat --version | awk '{print $2}' | awk -F. '{printf("%d%03d%03d\n", $1, $2, $3)}')
    set use_bat 1
end

if test $use_bat -eq 1
    if test $bat_version -ge $batcat_version
        alias cat='bat'
    else
        alias cat='batcat'
    end
end

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
