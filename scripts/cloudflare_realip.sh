#!/usr/bin/env bash
# Generates nginx config for Cloudflare IPs
# 2016-12-15

declare -a ipv4 ipv6 IPList

ipv4=$(wget -qO - https://www.cloudflare.com/ips-v4)
ipv6=$(wget -qO - https://www.cloudflare.com/ips-v6)

IPList=( ${ipv4[@]} ${ipv6[@]} )

for i in ${IPList[@]}; do
  printf 'set_real_ip_from %s;\n' "$i"
done

printf 'real_ip_header CF-Connecting-IP;\n'
