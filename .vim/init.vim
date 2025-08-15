set termencoding=utf-8


" ======== base ========

"文字コードをUTF-8に設定
set encoding=utf-8
set fileencodings=utf-8,cp932,sjis,iso-2022-jp,euc-jp,us-ascii
set fileformats=unix,dos,mac
set ambiwidth=double

" Python pathを設定
"let g:python3_host_prog = system('echo -n $(which python3)')

if &modifiable
    set fileencoding=utf-8
endif

if has('nvim')
    let s:runs_on = 'nvim'
else
    let s:runs_on = 'vim'
endif

let s:backup_dir = expand('~/.cache/' . s:runs_on . '/backup')
let s:swap_dir = expand('~/.cache/' . s:runs_on . '/swap')
let s:undo_dir = expand('~/.cache/' . s:runs_on . '/undo')

execute 'set directory=' . s:swap_dir
execute 'set backupdir=' . s:backup_dir
if has('persistent_undo')
    execute 'set undodir=' . s:undo_dir
    set undofile
endif

if !isdirectory(s:backup_dir)
    call mkdir(s:backup_dir, 'p')
endif

if !isdirectory(s:swap_dir)
    call mkdir(s:swap_dir, 'p')
endif

if !isdirectory(s:undo_dir)
    call mkdir(s:undo_dir, 'p')
endif

let s:colorscheme = getenv('VIM_COLORSCHEME')
if empty(s:colorscheme)
    let s:colorscheme = 'monokai_pro'
endif

syntax on
execute 'colorscheme' s:colorscheme

" ヘルプを日本語にする
set helplang=ja,en
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" 行末までコピー
set display=lastline
" 補完メニューの高さ
set pumheight=10
" ビープ音を消す
set visualbell t_vb=
" ビープ音を可視化
set visualbell
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
" 改行時に前の行の構文を確認してインデント
set smartindent
" 自動インデント
set autoindent

" マウス設定
set mouse=a
" set ttymouse=xterm2

" vimを起動しているターミナルのフォーカスが外れた時にマウスの左クリックを無効にする
augroup Mouse
    autocmd!
    autocmd FocusGained * call s:OnFocusGained()
    autocmd FocusLost * call s:OnFocusLost()
augroup END

function! s:OnFocusGained() abort
    autocmd CursorMoved,CursorMovedI,ModeChanged,WinScrolled * ++once call s:EnebleLeftMouse()
    noremap  <LeftMouse> <Cmd>call <SID>EnebleLeftMouse()<CR>
    inoremap <LeftMouse> <Cmd>call <SID>EnebleLeftMouse()<CR>
endfunction

function! s:EnebleLeftMouse() abort
    noremap  <LeftMouse> <LeftMouse>
    inoremap <LeftMouse> <LeftMouse>
endfunction

function! s:OnFocusLost() abort
    noremap  <LeftMouse> <nop>
    inoremap <LeftMouse> <nop>
endfunction





" set guifont=CaskaydiaCove_Nerd_Font:h10
set guifont=HackGenNerd:h10

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
" 補完
set completeopt=menuone,noinsert


" ======== filetype ========

augroup fileTypeIndent
    autocmd!
    autocmd BufRead,BufNewFile *.htm setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.html setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.jsx setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.tsx setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END




" ======== mappings ========

let mapleader = "\<Space>"

nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
nnoremap Y y$

" 保存時にsudo権限で無理やり保存
cnoremap w!! w !sudo tee > /dev/null %<CR>

nnoremap j gj
nnoremap k gk

nmap <Esc><Esc> :nohlsearch<CR><Esc>

inoremap <silent> jj <ESC>
inoremap <silent> jk <ESC>

nnoremap J 5j
nnoremap K 5k

nnoremap U :redo<CR>

nnoremap <C-d> viw
vnoremap <C-d> <Nop>

" VISUALモードでインデントをしたとき、選択範囲を選択したままにする
xnoremap < <gv`>
xnoremap > >gv`>

nnoremap * *N

nnoremap ss :split<CR>
nnoremap sv :vsplit<CR>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l


" ======== alias ========

command Q qa


if filereadable(expand('~/.vim/tokens.vim'))
    source ~/.vim/tokens.vim
endif

if filereadable(expand('~/.vim/dein.vim'))
    source ~/.vim/dein.vim
endif

if filereadable(expand('~/.vim/local.vim'))
    source ~/.vim/local.vim
endif
