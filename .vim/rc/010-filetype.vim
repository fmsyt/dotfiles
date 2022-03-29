augroup filetypedetect
    au BufRead,BufNewFile *.yaml setfiletype ansible
    au BufRead,BufNewFile *.yml  setfiletype ansible
augroup END

