# env

set -x PATH $HOME/.local/bin $PATH

if test -d $HOME/.cargo
    set -x PATH $HOME/.cargo/bin $PATH
end

if test -d $HOME/.deno
    set -gx DENO_INSTALL $HOME/.deno
    set -x PATH $DENO_INSTALL/bin $PATH
end

if command -v vim >/dev/null 2>&1
    set -gx EDITOR vim
end

if test -d $HOME/.pyenv
    set -Ux PYENV_ROOT $HOME/.pyenv
    set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
end


if test -e /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end




# aliases

abbr sudo 'sudo -E'
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
