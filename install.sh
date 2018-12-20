#!/bin/bash

# /home/{username}
home=`echo ~`
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# If vim-plug has not installed, install it.
if [ -e ${home}/.vim ] ; then
	echo vim-plug has installed.
else
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

count=0
for file in $(ls $SCRIPT_DIR -1 --ignore={*.sh,README.md})
do
	to="${home}/.${file}"
	if [ ! -e ${to} ] ; then
		ln -s $SCRIPT_DIR/${file} ${to}
		echo "created $to"
		count=$((count+1))
	fi
done

if [ $count -gt 0 ] ; then
	echo "$count links has created."
fi

unset count
unset home
unset SCRIPT_DIR
