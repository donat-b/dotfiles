#!/usr/bin/env sh

function main() {
  unset http_proxy https_proxy
  local FORMAT=best
  local OPTIMUS='optirun --'
  local URL=''

  # TODO auto select FullHD
  while :; do
    case "$1" in
      --bestdash)
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
  URL="ytdl://$(xclip -o)" # -selection clipboard)

  $OPTIMUS mpv --log-file=/tmp/mpv.log --no-resume-playback --ytdl-format="$FORMAT" "$URL"
}

main "$@"
