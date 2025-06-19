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

let s:cache_state_file = expand('~/.cache/vim_mode_state')
let s:current_mode = getenv('VIM_MODE')

if (filereadable(s:cache_state_file))
    let s:previous_mode = readfile(s:cache_state_file)[0]
else
    let s:previous_mode = ''
endif

if s:current_mode != 'cli'
    autocmd VimEnter * echomsg 'Start `VIM_MODE=cli vim` to load all plugins.' 
endif

" dein の設定
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    call dein#load_toml(s:toml_base, { 'lazy': 0 })

    if s:current_mode == 'cli'
        call dein#load_toml(s:toml_cli, { 'lazy': 0 })
        call dein#load_toml(s:toml_cli_lazy, { 'lazy': 1 })
    endif

    call dein#end()
    call dein#save_state()
endif

if (s:current_mode != s:previous_mode)
    call dein#clear_state()
    call writefile([s:current_mode], s:cache_state_file)
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


if dein#is_sourced("vim-airline")
    let s:colorscheme = get(g:, 'colorscheme', 'default')
    let g:lightline = { 'colorscheme': s:colorscheme }
endif
