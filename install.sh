#!/bin/bash

home=`echo ~`

if [ -e ${home}/.vim ] ; then
	echo vim-plug has installed.
else
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

count=0
for file in $(ls `dirname $0` -1 --ignore=*.sh)
do
	to="${home}/.${file}"
	if [ ! -e ${to} ] ; then
		ln -s `dirname $0`/dotfiles/${file} ${to}
		echo "created $to"
		count=$((count+1))
	fi
done

if [ $count -gt 0 ] ; then
	echo "$count links has created."
fi

unset count
unset home
