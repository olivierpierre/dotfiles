#!/bin/bash

# ----------------
# Install packages
# ---------------
sudo apt update 

read -p "Do you want to upgrade installed packages? [y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	sudo apt upgrade -y
fi

cat debian-packages/default | xargs sudo apt install -y

for f in `ls debian-packages/optional/*`; do
	name=`basename $f`
	read -p "Do you want to install $name? [y/n]" -n 1 -r
	echo    # (optional) move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		cat $f | xargs sudo apt install -y
	fi
done

# ---------------------------
# Backup and symlink dotfiles
# ---------------------------
for f in `ls dotfiles/*`; do
	name=`basename $f`
	# Backup
	if [ -f ~/.$name ]; then
		echo "~/.$name already exists, backing it up as ~/.$name.bak"
		mv ~/.$name ~/.$name.bak
	fi	
	if [ -L ~/.$name ]; then
		echo "~/.$name already exists, backing it up as ~/.$name.bak"
		mv ~/.$name ~/.$name.bak
	fi	


	# Symlink
	ln -s $PWD/$f ~/.$name
done

# ---------
# SSH stuff
# ---------
if [ -e ~/.ssh/config ]; then
	echo "~/.ssh/config already exists, backing it up as ~/.ssh/config.bak"
	mv ~/.ssh/config ~/.ssh/config.bak
fi

if [ -L ~/.ssh/config ]; then
	echo "~/.ssh/config already exists, backing it up as ~/.ssh/config.bak"
	mv ~/.ssh/config ~/.ssh/config.bak
fi

if [ ! -e ~/.ssh ]; then
	mkdir ~/.ssh
fi

ln -s $PWD/ssh/config ~/.ssh/config

# --------
# Hostfile
# --------
while read l; do
	present=`grep "$l" /etc/hosts`
	if [ "$present" == "" ]; then
		sudo echo $l >> /etc/hosts
	fi
done < hostfile/hosts

# ---------
# Vim stuff
# ---------
git submodule init
git submodule update

if [ -e ~/.vim ]; then
	echo "~/.vim exists, baking it up as ~/.vim/bak"
	mv ~/.vim ~/.vim.bak
fi

if [ -L ~/.vim ]; then
	echo "~/.vim exists, baking it up as ~/.vim/bak"
	mv ~/.vim ~/.vim.bak
fi

ln -s $PWD/vim/ ~/.vim

# ---------
# Oh-my-zsh
# ---------
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

for f in `ls oh-my-zsh/*`; do
	name=`basename $f`
	if [ -e ~/.oh-my-zsh/custom/$name ]; then
		echo "~/.oh-my-zsh/custom/$name already exists, backing it up as ~/.oh-my-zsh/custom/$name.bak"
		mv ~/.oh-my-zsh/custom/$name ~/.oh-my-zsh/custom/$name.bak 
	fi
	if [ -L ~/.oh-my-zsh/custom/$name ]; then
		echo "~/.oh-my-zsh/custom/$name already exists, backing it up as ~/.oh-my-zsh/custom/$name.bak"
		mv ~/.oh-my-zsh/custom/$name ~/.oh-my-zsh/custom/$name.bak 
	fi

	ln -s $PWD/oh-my-zsh/$name ~/.oh-my-zsh/custom/$name
done

# -----------
# Dconf stuff
# -----------
for f in `ls dconf`; do
	name=`basename $f`
	conf_str=${name//_/\/}
	dconf load dconf/$conf_str < $f
done

# Tilix profile symlink
sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
