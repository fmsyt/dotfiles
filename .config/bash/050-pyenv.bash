# exit when pyenv is not installed
if ! command -v pyenv >/dev/null; then
    return
fi

if [ -d $HOME/.pyenv ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/shims:$PATH"
    eval "$(pyenv init -)"
fi
