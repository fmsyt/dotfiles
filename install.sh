#!/bin/sh

DOTPATH=$(cd $(dirname $0); pwd)
DEIN_INSTALL_PATH=$HOME/.cache/dein

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
        echo "$append_text" >> $file_path
    fi
done


cd $DOTPATH/ln

for f in ??*
do
    link="$(pwd)/$f"
    file_path="$HOME/.$f"

    ln -snfv "$link" "$file_path"
done

git config --global include.path $DOTPATH/dotfiles/gitconfig


unset link
unset append_text
unset file_path

