let g:copilot_no_maps = v:true

" ui で何を使用するか指定
call ddc#custom#patch_global('ui', 'native')

call ddc#custom#patch_global('sources', [
    \   'omni',
    \   'vim-lsp',
    \   'copilot',
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
    \   },
    \ })


call ddc#custom#patch_filetype(['php'], 'sourceParams', #{
    \   omni: #{
    \     omnifunc: 'phpactor#Complete'
    \   }
    \ })



call ddc#enable()

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
