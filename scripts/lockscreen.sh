#!/usr/bin/env sh
# Locks screen with i3lock using DXHR themed background
# req: imagemagick, i3lock
# 2015-11-15

declare -r lockscreen_bg=/tmp/ls_bg.png
declare -r overlay="$HOME/dotfiles/media/dx_triangles.png"
declare -r i3lock_cmd='i3lock --nofork -c 000000 --ignore-empty-password --show-failed-attempts'
declare -r c_blur=4x3
declare -r c_cmp_method=linearlight

function genbg {
  import -window root -quality 70 -define jpeg:dct-method=fastest -compress none jpeg:- \
    | convert - -blur $c_blur "$overlay" -compose $c_cmp_method -composite "$lockscreen_bg"
}

#xset dpms force suspend
killall -SIGUSR1 dunst&

if genbg; then
  $i3lock_cmd --image="$lockscreen_bg"
else
  printf 'lockscreen: unable to generate background\n'
  $i3lock_cmd
fi

killall -SIGUSR2 dunst
rm $lockscreen_bg
