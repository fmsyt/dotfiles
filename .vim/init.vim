set termencoding=utf-8

if filereadable(expand('~/.vim/common.vim'))
    source ~/.vim/common.vim
endif

if filereadable(expand('~/.vim/tokens.vim'))
    source ~/.vim/tokens.vim
endif

if filereadable(expand('~/.vim/dein.vim'))
    source ~/.vim/dein.vim
endif

if filereadable(expand('~/.vim/local.vim'))
    source ~/.vim/local.vim
endif
