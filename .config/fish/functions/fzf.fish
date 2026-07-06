function fzf --wrap fzf --description 'fzf with adaptive preview'
    # _fzf_preview_handler に {} を渡すように指定
    # fish の関数を外部コマンドから呼ぶために `fish -c` を経由させます
    command fzf --preview '_fzf_preview_handler {}' $argv
end
