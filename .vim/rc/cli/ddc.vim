echom "ddc.vim configuration"

" Use around source.
call ddc#custom#patch_global('sources', [
    \   'around',
    \   'omni',
    \   'lsp',
    \ ])

" Use matcher_head and sorter_rank.
call ddc#custom#patch_global('sourceOptions', #{
    \   _: #{
    \       matchers: ['matcher_head'],
    \       sorters: ['sorter_rank'],
    \       converters: ['converter_remove_overlap']
    \   },
    \   omni: #{ mark: 'O' },
    \   around: #{
    \       mark: 'Around',
    \   },
    \   lsp: #{
    \     mark: 'lsp',
    \     forceCompletionPattern: '\.\w*|:\w*|->\w*',
    \   },
    \ })

call ddc#custom#patch_global('sourceParams', #{
    \   lsp: #{
    \     snippetEngine: denops#callback#register({
    \           body -> vsnip#anonymous(body)
    \     }),
    \     enableResolveItem: v:true,
    \     enableAdditionalTextEdit: v:true,
    \   }
    \ })


call ddc#custom#patch_filetype(['php'], 'sourceParams', #{
    \   omni: #{
    \     omnifunc: 'phpactor#Complete'
    \   }
    \ })


" Use ddc.
call ddc#enable()

