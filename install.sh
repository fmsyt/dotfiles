#!/bin/sh


DOTPATH=$HOME/dotfiles
DEIN_INSTALL_PATH=$HOME/.vim/bundles


cd $DOTPATH

./dein.sh $DEIN_INSTALL_PATH


cd $DOTPATH/source

for f in ??*
do
    append_text="source $(pwd)/$f"
    file_path="$HOME/.$f"

    touch $file_path
    grep -x "$append_text" $file_path

    if [ $? != 0 ]; then
        "$append_text" >> $file_path
    fi
done


cd $DOTPATH/ln

for f in ??*
do
    link="$(pwd)/$f"
    file_path="$HOME/.$f"

    ln -snfv "$link" "$file_path"
done

# update git config
# 基本設定
git config --global color.ui true
git config --global core.autocrlf input
git config --global pull.ff only
git config --global merge.ff false

# エイリアス指定
git config --global alias.st status
git config --global alias.df diff
git config --global alias.cm commit
git config --global alias.br branch
git config --global alias.ps push
git config --global alias.pl pull
git config --global alias.co checkout

# 日本語のファイル名をエンコードしない
git config --global core.quotepath false

# 認証情報をキャッシュ
git config --global credential.helper 'cache --timeout=86400'

unset link
unset append_text
unset file_path


