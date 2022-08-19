if test -e $HOME/.pyenv
    set -Ux PYENV_ROOT $HOME/.pyenv
    set PATH $PYENV_ROOT/shims $PATH
    alias brew="env PATH=(string replace (pyenv root)/shims '' \"\$PATH\") brew"
end

