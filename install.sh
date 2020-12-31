#!/bin/bash

HOME=`echo ~`
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# If vim-plug has not installed, install it.
if [ -e ${HOME}/.vim ] ; then
	echo vim-plug has already installed.
else
	echo "Install vim-plug"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

#List up all files
for file in $(ls $SCRIPT_DIR -1 --ignore={*.sh,README.md})
do
	to="${HOME}/.${file}"

	if [ ! -e $to ] ; then
		#Create dotfile in HomeDirectory
		ln -s $SCRIPT_DIR/$file $to
		echo "created $to"

	elif [ $file = "bashrc" ] ; then
		cmd="source $SCRIPT_DIR/bashrc"

		grep "$cmd" $to > /dev/null
		if [ $? -ne 0 ] ; then
			echo $cmd >> $to
			echo "added line for $to"
		fi
		unset cmd
	fi
done

# update git config
# $B4pK\@_Dj(B
git config --global color.ui true
git config --global core.autocrlf input
git config --global pull.ff only
git config --global merge.ff false

# $B%(%$%j%"%9;XDj(B
git config --global alias.st status
git config --global alias.df diff
git config --global alias.cm commit
git config --global alias.br branch
git config --global alias.ps push
git config --global alias.pl pull
git config --global alias.co checkout

# $BF|K\8l$N%U%!%$%kL>$r%(%s%3!<%I$7$J$$(B
git config --global core.quotepath false

# $BG'>Z>pJs$r%-%c%C%7%e(B
git config --global credential.helper 'cache --timeout=86400'

unset file
unset to
unset HOME
unset SCRIPT_DIR


