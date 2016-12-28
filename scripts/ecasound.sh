#!/usr/bin/env sh
# 2016-12-28

declare -r FORMAT=s16_le,2,44100 # CD
declare -r BUFFER=64

sudo ecasound -r:20 -B:rtlowlatency -b:$BUFFER -f:$FORMAT -i:alsaplugin,1,1 -o:stdout -d:1
