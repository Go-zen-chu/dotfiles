#!/usr/bin/env bash
set -ux

source ./make/util.sh
echo_green "[INFO] Setup git"

# ignore generated files 
git config --global core.excludesfile "${HOME}/dotfiles/git/global-ignore"
# change push strategy
git config --global push.default current
# merges when pulling remote
git config --global pull.rebase false

os=$(check_os)
# check command exists
if ! hash tig 2>/dev/null ; then
	case "${os}" in
	"MacOS")
		brew install tig
		;;
	"CentOS")
		echo_red "TBD"
		;;
	"ArchLinux")
		sudo pacman -Sy --noconfirm tig
		;;
	esac
fi
if [[ ! -f "${HOME}/.tigrc" ]] ; then
	cp ./git/.tigrc "${HOME}"
fi