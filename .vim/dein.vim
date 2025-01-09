if !executable('git')
    echo 'git is not found.'
    finish
endif

" インストールディレクトリの指定
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

let s:toml_base = expand('~/.vim') . '/plugins.toml'
let s:toml_cli = expand('~/.vim') . '/plugins_cli.toml'
let s:toml_cli_lazy = expand('~/.vim') . '/plugins_cli_lazy.toml'

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

    call dein#load_toml(s:toml_base, { 'lazy': 0 })

    if $VIM_MODE == "cli"
        call dein#load_toml(s:toml_cli, { 'lazy': 0 })
        call dein#load_toml(s:toml_cli_lazy, { 'lazy': 1 })
    else
        augroup MinimalPlugins
            autocmd!
            autocmd VimEnter * echomsg "Plugins loaded minimal. Run vim with `VIM_MODE=cli` to load all plugins."
        augroup END
    endif

    call dein#end()
    call dein#save_state()
endif

" 各プラグインのインストールチェック（なかったら自動的に追加される）
if dein#check_install()
    call dein#install()
endif

" call dein#check_update(v:true)

" プラグイン再読み込み
"call map(dein#check_clean(), "delete(v:val, 'rf')")
"call dein#recache_runtimepath()

if dein#is_sourced("ddc.vim")
    source ~/.vim/ddc.vim
endif

colorscheme monokai_pro

if dein#is_sourced("vim-airline")
    let g:lightline = { 'colorscheme': 'monokai_pro' }
endif
