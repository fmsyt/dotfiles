"文字コードをUTF-8に設定
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis,utf-8,us-ascii
set fileformats=unix,dos,mac
set ambiwidth=double

if &modifiable
    set fileencoding=utf-8
endif

" swpファイル出力先
set directory=$HOME/.vim/swap

" バックアップファイル出力先
set backupdir=$HOME/.vim/backup

" undoファイル出力先
if has('persistent_undo')
    set undodir=$HOME/.vim/undo
    set undofile
endif


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
set mouse=nvi
set ttymouse=xterm2

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
