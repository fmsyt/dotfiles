if [ -f $HOME/.pyenv ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/shims:$PATH"
    eval "$(pyenv init -)"
fi