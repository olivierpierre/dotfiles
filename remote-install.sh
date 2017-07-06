#!/bin/bash

if [ -e ~/.dotfiles ]; then
	read -p "~/.dotfiles already exist, it will be overwritten, continue? [y/n]" -n 1 -r
	echo
	if [[ $REPLY =~ ^[Nn]$ ]]; then
		exit
	fi
	rm -rf ~/.dotfiles
fi

git clone https://github.com/olivierpierre/dotfiles.git ~/.dotfiles
cd ~/.dotfiles; ./install.sh
