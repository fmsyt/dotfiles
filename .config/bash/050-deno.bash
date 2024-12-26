if [ -f $HOME/.deno/env ]; then
    source $HOME/.deno/env
fi

if [ -f $HOME/.local/share/bash-completion/completions/deno.bash ]; then
    source $HOME/.local/share/bash-completion/completions/deno.bash 
fi
