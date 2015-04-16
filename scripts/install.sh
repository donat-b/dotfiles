#!/usr/bin/env sh
#
# Make links for configs in home directory
#
# donat@opmbx.org
# 2014-12-25

DOTDIR=$HOME/dotfiles

function sl() {
	# <name> <config name>
	if [ -h "$HOME/$2" ]; then
		printf 'warn: %s exists - symlink\n' "$1"
	elif [ -e "$HOME/$2" ]; then
		printf 'warn: %s exists -%s\n' "$1" "$(file "$HOME/$2" | cut -d: -f2)"
	else
		ln -sv "$DOTDIR/$1" "$HOME/$2"
	fi
}

# git
sl gitconfig .gitconfig

# mpv
sl mpv/mpv.conf .config/mpv/mpv.conf
sl mpv/input.conf .config/mpv/input.conf

# mutt
sl muttrc .muttrc

# ranger
sl rangerrc .config/ranger/rc.conf
sl ranger/rifle.conf .config/ranger/rifle.conf

# tmux
sl tmux/conf .tmux.conf

# vim
sl vimrc .vimrc

# x11 stuff
sl i3config .i3/config
sl i3status .config/i3status/config
sl xinitrc .xinitrc
sl Xresources .Xresources

# zsh
sl zsh/env .zshenv
sl zsh/rc .zshrc
sl zsh/profile .zprofile
