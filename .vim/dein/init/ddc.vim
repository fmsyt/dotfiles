" Use around source.
call ddc#custom#patch_global('sources', ['around'])

" Use matcher_head and sorter_rank.
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
"call ddc#custom#patch_filetype(['c', 'cpp'], 'sources', ['around', 'clangd'])
"call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', {
"    \ 'clangd': {'mark': 'C'},
"    \ })
"call ddc#custom#patch_filetype('markdown', 'sourceParams', {
"    \ 'around': {'maxSize': 100},
"    \ })

" Use ddc.
call ddc#enable()
