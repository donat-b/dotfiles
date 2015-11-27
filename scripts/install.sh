#!/usr/bin/env sh
#
# Make links for configs in home directory
#
# donat@opmbx.org
# 2014-12-25

declare -r DOTDIR=$HOME/dotfiles
declare -A config_paths

function link() {
  ln -sv --force "$1" "$2"
}

function sl() {
  # <path to config in dotfiles> <path to config in $HOME>
  if [ -h "$HOME/$2" ] && [ ! -e "$HOME/$2" ]; then
    printf 'warn: %s exists - a broken symlink\n' "$1"
    link "$DOTDIR/$1" "$HOME/$2"
  elif [ -e "$HOME/$2" ]; then
    # TODO:
    # decide what is the appropriate action in the case
    printf 'warn: %s exists -%s\n' "$1" "$(file "$HOME/$2" | cut -d: -f2)"
  else
    link "$DOTDIR/$1" "$HOME/$2"
  fi
}

config_paths=(
# [source]=destination
# destination can be a dot if a source has the same name
  [gimp/rc]=.gimp-2.8/gimprc
  [gitconfig]=.
  [mpv/mpv.conf]=.config/mpv/mpv.conf
  [mpv/input.conf]=.config/mpv/input.conf
  [muttrc]=.
  [ranger/rc]=.config/ranger/rc.conf
  [ranger/rifle.conf]=.config/ranger/rifle.conf
  [tmux/conf]=.tmux.conf
  [vim/vimrc]=.vimrc
  [i3/config]=.i3/config
  [i3/i3status]=.config/i3status/config
  [X/xinitrc]=.xinitrc
  [X/Xresources]=.Xresources
  [zsh/env]=.zshenv
  [zsh/rc]=.zshrc
  [zsh/profile]=.zprofile
  [weechat/alias.conf]=.weechat/alias.conf
  )

for i in "${!config_paths[@]}"; do
  [ "${config_paths[$i]}" == '.' ] && \
    config_paths[$i]=".$i"
  sl "$i" "${config_paths[$i]}"
done
