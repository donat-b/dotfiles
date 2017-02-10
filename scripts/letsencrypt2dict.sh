#!/usr/bin/env bash

declare -r HOST=$1

printf 'vault_ssl:\n'
printf '  key: |\n'
sed 's/^/    /' /etc/letsencrypt/live/$HOST/privkey.pem
printf '  cert: |\n'
sed 's/^/    /' /etc/letsencrypt/live/$HOST/fullchain.pem
