#!/usr/bin/env sh
#
# Make links for configs in home directory
#
# donat@opmbx.org
# 2014-12-25

DOTDIR=$HOME/dotfiles

function link() {
  ln -sv --force "$1" "$2"
}

function sl() {
	# <path to config in dotfiles> <path to config in $HOME>
	if [ -h "$HOME/$2" ] && [ ! -e "$HOME/$2" ]; then
		printf 'warn: %s exists - a broken symlink\n' "$1"
		link "$DOTDIR/$1" "$HOME/$2"
	elif [ -e "$HOME/$2" ]; then
		printf 'warn: %s exists -%s\n' "$1" "$(file "$HOME/$2" | cut -d: -f2)"
	else
		link "$DOTDIR/$1" "$HOME/$2"
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
sl ranger/rc .config/ranger/rc.conf
sl ranger/rifle.conf .config/ranger/rifle.conf

# tmux
sl tmux/conf .tmux.conf

# vim
sl vim/vimrc .vimrc

# x11 stuff
sl i3/config .i3/config
sl i3/i3status .config/i3status/config
sl X/xinitrc .xinitrc
sl X/Xresources .Xresources

# zsh
sl zsh/env .zshenv
sl zsh/rc .zshrc
sl zsh/profile .zprofile

# gimp
sl gimp/rc .gimp-2.8/gimprc

# weechat
sl weechat/alias.conf .weechat/alias.conf
