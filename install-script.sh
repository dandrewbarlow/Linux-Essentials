#! /bin/bash


# get distro
distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')

# update linux and install packages using native package manager, assume yes to eliminate user input
if [ $distro = 'fedora' ]
then
  sudo dnf -y upgrade
  sudo dnf -y install "$(cat ./my_requirements.txt)"
elif [ $distro = 'ubuntu' ] || [ $distro = 'debian' ]
then
  sudo apt-get -y update && sudo apt-get -y upgrade
  sudo apt-get -y install "$(cat ./my_requirements.txt)"
elif [ $distro = 'arch' ] || [ $distro = 'manjaro' ]
then
  sudo pacman --noconfirm -Syu
  sudo pacman --noconfirm -S "$(cat ./my_requirements.txt)"
fi

# setup git globally
./git-config.sh

# install atom
# https://flight-manual.atom.io/getting-started/sections/installing-atom/
# added propt bc vscode is starting to replace it for me
echo "Install Atom?"
select atom in 'y' 'n'; do
	case "$atom" in
		y)
			./atom-install.sh
			break
			;;
		n)
			break
			;;
	esac
done


# install OSX fonts bc they're pretty
# https://github.com/blaisck/sfwin
./fonts.sh

# install oh-my-zsh
# https://github.com/ohmyzsh/ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# download & install the spaceship theme
# https://github.com/denysdovhan/spaceship-prompt
./spaceship-theme.sh

# NeoVim setup script
./vim.sh

# Haskell setup script
./haskell.sh

# install kite
./kite-install.sh

# froggie
wget https://i.imgur.com/voY8SXt.jpg -O ~/Pictures/froggie.jpg

# get some music from the web if a want it
echo "Download some music from the web? (its death grips)"
select music in 'y' 'n'; do
	case "$music" in
		y)
			./music.sh
			break
			;;
		n)
			break
			;;
	esac
done



