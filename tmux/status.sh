#!/usr/bin/env sh

if [ $1 -eq 1 ]; then
	printf ''
else
	printf '%s' $(hostname)
fi
