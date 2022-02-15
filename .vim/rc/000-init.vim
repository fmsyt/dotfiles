" インストールディレクトリの指定
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:toml_file = expand('~/.config/nvim/dein') . '/plugins.toml'
let s:toml_dir = expand('~/.vim/dein/plugins')

" dein.vim ディレクトリがruntimepathに入っていない場合、追加
if match( &runtimepath, '/dein.vim' ) == -1
    " dein_repo_dir で指定した場所に dein.vim が無い場合、git cloneしてくる
	if !isdirectory(s:dein_repo_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
	endif
	execute 'set runtimepath+=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" dein の設定
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)


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



    call dein#end()
	call dein#save_state()
endif

" 各プラグインのインストールチェック（なかったら自動的に追加される）
if dein#check_install()
	call dein#install()
endif

" プラグイン再読み込み
"call map(dein#check_clean(), "delete(v:val, 'rf')")
"call dein#recache_runtimepath()
