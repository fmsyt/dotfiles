" setting

for f in split(glob('~/.vim/rc/*.vim'), '\n')
    exe 'source' f
endfor

if $VIM_MODE == "" || $VIM_MODE == "cli"
    source ~/.vim/rc/cli/init.vim
elseif $VIM_MODE == "slim"
    source ~/.vim/rc/slim/init.vim
endif
