let g:copilot_no_maps = v:true

" ui で何を使用するか指定
call ddc#custom#patch_global('ui', 'native')

call ddc#custom#patch_global('sources', [
    \   'copilot',
    \   'omni',
    \   'vim-lsp',
    \   'file',
    \   'around',
    \ ])

call ddc#custom#patch_global('sourceOptions', {
    \   '_': {
    \     'matchers': ['matcher_head'],
    \     'sorters': ['sorter_rank']
    \   },
    \   'around': {
    \     'mark': 'around',
    \   },
    \   'file': {
    \     'mark': 'file',
    \     'isVolatile': v:true,
    \     'forceCompletionPattern': '\S/\S*',
    \     'maxItems': 5,
    \   },
    \   'vim-lsp': {
    \     'mark': 'lsp',
    \     'forceCompletionPattern': '\.\w*|:\w*|->\w*',
    \   },
    \   'copilot': {
    \     'mark': 'Copilot',
    \     'matchers': [],
    \     'minAutoCompleteLength': 0,
    \   },
    \   'omni': {
    \     'mark': 'O',
    \     'maxItems': 5,
    \   },
    \ })


call ddc#custom#patch_filetype(['php'], 'sourceParams', #{
    \   omni: #{
    \     omnifunc: 'phpactor#Complete'
    \   }
    \ })



call ddc#enable()


" https://qiita.com/maachan_9692/items/9b507fd043424013abde

" <TAB>: completion.
inoremap <expr> <TAB>
    \ pumvisible() ? '<C-n>' :
    \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
    \ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr> <S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'


" <C-j>: completion.
inoremap <expr> <C-j>
    \ pumvisible() ? '<space>' :
    \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
    \ '<TAB>' : ddc#map#manual_complete()
" <C-k>: completion back.
inoremap <expr> <C-k>  pumvisible() ? '<C-p>' : ''
