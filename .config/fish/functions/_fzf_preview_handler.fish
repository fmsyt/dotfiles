function _fzf_preview_handler --argument-names file
    # ファイルが存在しない、またはディレクトリの場合は通常の処理
    if not test -f "$file"
        if test -d "$file"
            ls -la "$file"
        end
        return
    end

    # MIMEタイプを取得
    set -l mime (file --mime-type -b "$file")

    switch "$mime"
        case 'image/*'
            # 画像なら WezTerm の imgcat を使用
            wezterm imgcat "$file"
        case 'text/*' application/json application/javascript application/xml
            # テキスト系は bat で表示
            bat --color=always --style=numbers --line-range :500 "$file"
        case '*'
            # その他（バイナリなど）はファイル情報を表示
            file "$file"
    end
end
