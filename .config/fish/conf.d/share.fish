# env

set -x PATH $HOME/.local/bin $PATH

if test -d $HOME/.cargo
    set -x PATH $HOME/.cargo/bin $PATH
end

if test -d $HOME/.deno
    set -gx DENO_INSTALL $HOME/.deno
    set -x PATH $DENO_INSTALL/bin $PATH
end

if type vim >/dev/null 2>&1
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

alias sudo='sudo -E '
alias ip='ip -color'

if which exa >/dev/null 2>&1
    alias ls='exa'
    alias ll='exa -gl'
    alias la='exa -agl'
else
    alias ll='ls -lF'
    alias la='ls -AlF'
end

if type bat >/dev/null 2>&1
    alias cat='bat -p --paging=never'
end


if type docker >/dev/null 2>&1
    alias d='docker'
    alias de='docker exec -it'

    if docker compose >/dev/null 2>&1
        alias dc='docker compose'
        alias dce='docker compose exec'
        alias dcu='docker compose up -d'
        alias dcub='docker compose up --build -d'

    else
        alias dc='docker-compose'
        alias dce='docker-compose exec'
        alias dcu='docker-compose up -d'
        alias dcub='docker-compose up --build -d'
    end
end
