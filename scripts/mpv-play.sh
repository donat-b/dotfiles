#!/usr/bin/env sh
function main() {
  unset http_proxy https_proxy
  FORMAT=best
  OPTIMUS='optirun --'

  while :; do
    case "$1" in
      --best)
        FORMAT='bestvideo+bestaudio/best'
        shift
        ;;
      --fullhd)
        FORMAT='137+bestaudio/best'
        shift
        ;;
      --intel)
        unset OPTIMUS
        shift
        ;;
      *)
        break
        ;;
    esac
  done
  F='ytdl://'$(xclip -o) # -selection clipboard)

  $OPTIMUS mpv --no-resume-playback --ytdl-format "$FORMAT" "$F" > /tmp/mpv.log 2>&1
}
main
