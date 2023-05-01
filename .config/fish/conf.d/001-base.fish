set -x PATH  $HOME/.cargo/bin $PATH
set -gx DENO_INSTALL $HOME/.deno
set -x PATH $DENO_INSTALL/bin $PATH

if type vim >/dev/null 2>&1
    export EDITOR=vim
    alias svim='EDITOR=vim sudoedit'
end
