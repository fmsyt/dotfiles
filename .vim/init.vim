"dein Scripts-----------------------------
if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin("$HOME/.cache/dein")

" Let dein manage dein
" Required:
call dein#add("$HOME/.cache/dein/repos/github.com/Shougo/dein.vim")

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

call dein#add('tpope/vim-surround')
call dein#add('scrooloose/nerdtree')
call dein#add('tpope/vim-commentary')

" vim下部のステータスラインを装飾
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('ryanoasis/vim-devicons')

" Ctrl + P でファイル検索
call dein#add('ctrlpvim/ctrlp.vim')

call dein#add('sheerun/vim-polyglot')
call dein#add('Erichain/vim-monokai-pro')
call dein#add('cohama/lexima.vim')

call dein#add('Shougo/deoplete.nvim')
if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
endif

let g:deoplete#enable_at_startup = 1
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/vimproc')
call dein#add('Shougo/neocomplcache')

" git管理で現行があった行の表示
call dein#add('airblade/vim-gitgutter')

" vimからgit操作
call dein#add('tpope/vim-fugitive')

" indent
call dein#add('Yggdroot/indentLine')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif

" プラグイン再読み込み
"call map(dein#check_clean(), "delete(v:val, 'rf')")
"call dein#recache_runtimepath()

"End dein Scripts-------------------------



" setting
runtime! rc/*.vim
