#!/usr/bin/env bash
set -e

CHANGES=$1
DISTRIBUTION=$2
KEYID=11BEDB61

sed -i -e "s/^Distribution:.*/Distribution: $DISTRIBUTION/" -e '/.tar.gz$/d' -e '/.dsc$/d' -e 's/^Architecture:.*/Architecture: all/' "$CHANGES"
debsign -k $KEYID "$CHANGES"
dput --check-version "$DISTRIBUTION" "$CHANGES"
