"文字コードをUTF-8に設定
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis,utf-8,us-ascii
set fileformats=unix,dos,mac
set ambiwidth=double



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
" ヘルプを日本語にする
set helplang=ja,en
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
"set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" 行末までコピー
nnoremap Y y$
" １行が長すぎる時の表示
set display=lastline
" 補完メニューの高さ
set pumheight=10
" ビープ音を消す
set visualbell t_vb=
" ビープ音を可視化
set visualbell
" 保存時にsudo権限で無理やり保存
cnoremap w!! w !sudo tee > /dev/null %<CR>
" 折りたたみ
set foldmethod=marker
set foldlevel=1
set foldcolumn=0

" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはオートインデント
set smartindent
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
"set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

colorscheme monokai_pro
let g:lightline = {
    \'colorscheme': 'monokai_pro',
    \}


set scrolloff=5

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:▸-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4
" 改翿時に前の翿の構文を確翿してインデント
set smartindent
" 翿動インデント
set autoindent

" マウス設定
"set mouse=a
"set ttymouse=xterm2

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" 補完
set completeopt=menuone,noinsert
" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

noremap <C-\> :vsplit<CR>


" NerdTreeToggle
nmap <C-b> :NERDTreeToggle<CR>

" airline
let g:airline_theme = 'bubblegum'

" neocomplete系
" 日本語を補完候補として取得しないようにする
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" indentLine
let g:indentLine_color_term =239
let g:indentLine_color_gui = '#708090'
let g:indentLine_char = '¦'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

let NERDTreeShowHidden=1

