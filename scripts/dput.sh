#!/usr/bin/env bash
set -e

CHANGES=$1
DISTRIBUTION=$2
KEYID=11BEDB61

printf 'Affected lines (%s):\n\n' "$CHANGES"
sed --quiet -e "s/^Distribution:.*/Distribution: $DISTRIBUTION/p" \
  -e '/.tar.gz$/p' \
  -e '/.dsc$/p' \
  -e 's/^Architecture:.*/Architecture: all/p' \
  "$CHANGES"
sed -i -e "s/^Distribution:.*/Distribution: $DISTRIBUTION/" \
  -e '/.tar.gz$/d' \
  -e '/.dsc$/d' \
  -e 's/^Architecture:.*/Architecture: all/' \
  "$CHANGES"

debsign -k $KEYID "$CHANGES"
dput --check-version "$DISTRIBUTION" "$CHANGES"
