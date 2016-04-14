#!/usr/bin/env bash
#
# Make links for configs in home directory
#
# donat@opmbx.org
# 2014-12-25

declare -r DOTDIR=$HOME/dotfiles
declare -A config_paths

function link() {
  local ddir=$(dirname "$2")
  [ ! -e "$ddir" ] && \
    mkdir -pv "$ddir"
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

function main() {
  config_paths=(
  # [source]=destination
  # destination can be '.' in which case it links the file using same name, prefixed with '.'
    [dunstrc]=.config/dunst/dunstrc
    [gdbinit]=.gdbinit
    [ghci]=.
    [gimp/rc]=.gimp-2.8/gimprc
    [gitconfig]=.
    [mpv/mpv.conf]=.config/mpv/mpv.conf
    [mpv/input.conf]=.config/mpv/input.conf
    [mutt/rc]=.muttrc
    [newsbeuter.conf]=.newsbeuter/config
    [qxkb.cfg]=.config/qxkb.cfg
    [ranger/rc]=.config/ranger/rc.conf
    [ranger/rifle.conf]=.config/ranger/rifle.conf
    [tmux/conf]=.tmux.conf
    [vim/vimrc]=.vimrc
    [vim/Vundle.vim]=.vim/bundle/Vundle.vim
    [i3/config]=.i3/config
    [i3/i3status]=.config/i3status/config
    [X/xprofile]=.xprofile
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
}

main
