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


if test -e '/home/linuxbrew/.linuxbrew/bin/brew'
    eval ('/home/linuxbrew/.linuxbrew/bin/brew' shellenv)
else if test -e '/opt/homebrew/bin/brew'
    eval ('/opt/homebrew/bin/brew' shellenv)
end




# aliases

