#!/usr/bin/env zsh
# Generates thumbnail tiles for every video in source directory
# 2016-01-23 donat@opmbx.org
#
# Usage: $0 -s /path/to/videos/ -o /where/to/put/thumbnails -t 'My film'

function main() {
  while :; do
    case "$1" in
      -h | --help)
        show_help
        exit 0
        ;;
      -s | --source)
        SOURCE_PATH="$2"
        [[ ! -d "${2}" ]] \
            && log ERROR 'Source directory does not exist' \
            && exit 1
        shift 2
        ;;
      -o | --output)
        OUTPUT_PATH="$2"
        [[ ! -d "${2}" ]] \
            && log ERROR 'Output directory does not exist' \
            && exit 1
        shift 2
        ;;
      -t | --title)
        TITLE="$2"
        shift 2
        ;;
      *)
        break
        ;;
    esac
  done

  # creating a tmp directory
  typeset -r tmpdir=$(mktemp -d)
  # frame scaling
  typeset -r scale='-1:190'
  # image quality (jpeg)
  typeset -ri quality=70
  # number of frames to capture
  typeset -ri frames=20
  typeset -r skip=00:00:15

  find "${SOURCE_PATH}" -maxdepth 1 -type f -print0 | while read -d $'\0' f; do
    printf 'Processing %s ...\n' "$f"
    # video duration
    typeset duration=$(ffprobe -i "$f" -show_entries format=duration -v quiet -of csv="p=0")
    typeset rate=$(($duration / $frames))
    typeset output_image="${OUTPUT_PATH}/$(basename $f | cut -d. -f1).jpg"
    printf 'Duration: %d s\n' "$duration"
    printf 'Rate: every %d s\n' "$rate"
    ffmpeg -nostdin -hide_banner -v panic -stats \
      -i "$f" -ss $skip -r 1/$rate -vcodec png \
      -aspect 16:9 -vf scale=$scale -quality $quality \
      "$tmpdir/capture-%002d.png"
    montage -title "\n$TITLE\n$(basename $f)" -geometry +3+3 \
      $tmpdir/capture*.png "$output_image"
    rm "$tmpdir/"*
  done
  rm -r "$tmpdir"
}

main "$@"
