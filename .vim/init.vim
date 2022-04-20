" setting

for f in split(glob('~/.vim/rc/*.vim'), '\n')
    exe 'source' f
endfor

if filereadable(expand('~/.vim/dein/init.vim'))
    source ~/.vim/dein/init.vim
endif
