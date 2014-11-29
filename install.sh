#!/usr/bin/env sh
# Istall symlinks

function sl() {
	# make a relative symlink in $HOME directory
	# <name> <config name>
	[ ! -f "$HOME/$2" ] && \
		ln -sr "$1" "$HOME/$2"
}

cd ~/dotfiles

# tmux
sl tmux.conf .tmux.conf
# vim
sl vimrc .vimrc
# zsh
sl zshenv .zshenv
