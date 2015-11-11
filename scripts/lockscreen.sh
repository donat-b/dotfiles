#!/usr/bin/env sh
# Locks screen with i3lock using DXHR themed background
# req: convert, scrot, i3lock
# 2015-11-15

declare -r lockscreen_bg=/tmp/ls_bg.png

function genbg {
  scrot "$lockscreen_bg"
  convert "$lockscreen_bg" -gaussian-blur 4x4 "$HOME/dotfiles/media/dx_triangles.jpg" -compose hardlight -composite "$lockscreen_bg"
}

killall -SIGUSR1 dunst&

if genbg; then
  i3lock --nofork -d -i "$lockscreen_bg"
else
  printf 'lockscreen: unable to generate background\n'
  i3lock --nofork -d -c 000000
fi

killall -SIGUSR2 dunst
rm $lockscreen_bg
