fish_add_path "$HOME/.local/bin"

set -gx DOTFILES_DIR (dirname (readlink -f "$HOME/.config"))

if test -d $HOME/.cargo
    fish_add_path $HOME/.cargo/bin
end

if test -d $HOME/.deno
    set -gx DENO_INSTALL $HOME/.deno
    fish_add_path $DENO_INSTALL/bin
end

if command -v vim >/dev/null 2>&1
    set -gx EDITOR vim
end
if command -v nvim >/dev/null 2>&1
    set -gx EDITOR nvim
    alias view='nvim -R'
end

if test -d $HOME/.pyenv
    set -gx PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
end


if test -e '/home/linuxbrew/.linuxbrew/bin/brew'
    eval ('/home/linuxbrew/.linuxbrew/bin/brew' shellenv)
else if test -e /opt/homebrew/bin/brew
    eval ('/opt/homebrew/bin/brew' shellenv)
end

set -gx AQUA_GLOBAL_CONFIG "$HOME/.config/aquaproj-aqua/aqua.yaml"
if command -v aqua >/dev/null 2>&1
    aqua completion fish | source
    fish_add_path (aqua root-dir)/bin
end


if command -v go >/dev/null 2>&1
    set -gx GOPATH $HOME/go
    set -gx GOROOT (go env GOROOT)
    fish_add_path $GOPATH/bin
    fish_add_path $GOROOT/bin
end

if command -v pnpm >/dev/null 2>&1
    set -gx PNPM_HOME "$HOME/.local/share/pnpm"
    if not string match -q -- $PNPM_HOME $PATH
        set -gx PATH "$PNPM_HOME" $PATH
    end
end

set -gx LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"
if command -v delta >/dev/null 2>&1
    set -gx LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/config.delta.yml"
end
