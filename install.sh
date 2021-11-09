#!/bin/bash

DOTPATH=$(cd $(dirname $0); pwd)
DEIN_INSTALL_PATH=$HOME/.cache/dein


function append_line() {

    local append_text=$1
    local file_path=$2

    # ファイルの作成先にsymlinkがある
    local link_path=$(readlink $file_path)
    if [ $? -eq 0 ]; then

        # symlinkの参照先が指定先と同一である
        if [ "$link_path" = "$file_path" ]; then
            unlink $link_path
        fi

        # リンクの参照先が存在しない
        if [ ! -e $link_path ]; then
            unlink $file_path
        fi
    fi

    touch $file_path
    grep -x "$append_text" $file_path

    if [ $? != 0 ]; then
        echo "$append_text" >> $file_path
    fi

    return 0
}



cd $DOTPATH
./dein.sh $DEIN_INSTALL_PATH


cd $DOTPATH/source

for f in ??*
do
    append_text="source $(pwd)/$f"
    file_path="$HOME/.$f"

    append_line "$append_text" "$file_path"
done


cd $DOTPATH/ln

for f in ??*
do
    link="$(pwd)/$f"
    file_path="$HOME/.$f"

    ln -snfv "$link" "$file_path"
done

git config --global include.path $DOTPATH/gitconfig


unset link
unset append_text
unset file_path

unset append_line

