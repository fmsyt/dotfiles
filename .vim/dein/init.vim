" インストールディレクトリの指定
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:toml = expand('~/.config/nvim/dein') . '/plugins.toml'
let s:toml_lazy = expand('~/.config/nvim/dein') . '/plugins_lazy.toml'
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

    call dein#load_toml(s:toml     , { 'lazy': 0 })
    call dein#load_toml(s:toml_lazy, { 'lazy': 1 })

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






" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', {
    \ '_': {
    \   'matchers': ['matcher_head'],
    \   'sorters': ['sorter_rank']},
    \ })

" Change source options
call ddc#custom#patch_global('sourceOptions', {
    \ 'around': {'mark': 'A'},
    \ })
call ddc#custom#patch_global('sourceParams', {
    \ 'around': {'maxSize': 500},
    \ })

" Customize settings on a filetype
call ddc#custom#patch_filetype(['c', 'cpp'], 'sources', ['around', 'clangd'])
call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', {
    \ 'clangd': {'mark': 'C'},
    \ })
call ddc#custom#patch_filetype('markdown', 'sourceParams', {
    \ 'around': {'maxSize': 100},
    \ })

