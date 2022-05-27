" Use around source.
call ddc#custom#patch_global('sources', [
    \   'around',
    \   'omni',
    \ ])

" Use matcher_head and sorter_rank.
call ddc#custom#patch_global('sourceOptions', {
    \   '_': {
    \       'matchers': ['matcher_head'],
    \       'omni': {'mark': 'O'},
    \       'sorters': ['sorter_rank'],
    \       'converters': ['converter_remove_overlap']
    \   },
    \   'around': {
    \       'mark': 'Around',
    \       'maxSize': 500
    \   },
    \   'vim-lsp': {
    \       'mark': 'LSP',
    \       'forceCompletionPattern': '\.|:|->|"\w+/*'
    \   }
    \ })


call ddc#custom#patch_filetype(['php'], 'sourceParams', {
    \   'omni': {
    \     'omnifunc': 'phpactor#Complete'
    \   }
    \ })


" Use ddc.
call ddc#enable()

