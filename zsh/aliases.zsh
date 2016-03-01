# Basic directory operations
alias ...='cd ../..'
alias -- -='cd -'

# redirections
alias -g GP='|grep -i'
alias -g NL='> /dev/null'

# List direcory contents
alias lha='ls -lah'
alias l='ls -la'
alias ll='ls -l'
alias lh='ls -lh'
alias lhs='ls -lhS'
alias la='ls -lA'

alias lad='ls -d -- .*(/)'   # only dot-directories
alias lsa='ls -a -- .*(.)'   # only dot-files
alias lsd='ls -d -- *(/)'    # only directories
alias lse='ls -ld -- *(/^F)' # only empty directories
alias lsen='ls -d *(/om[1])' # newest directory
alias lsx='ls -l -- *(*) | head $@ 2&>/dev/null'       # only executables
alias lsnew='=ls -rtlh -- *(.) | tail $@ 2&>/dev/null' # only the newest files
alias lsold="=ls -rtl -- *(.) | head $@ 2&>/dev/null"  # display the oldest files
alias lssmall="=ls -Sl -- *(.) | tail $@ 2&>/dev/null" # display the smallest files
alias lsbig="ls -lSh -- *(.) | grep -v total | head $@ 2&>/dev/null" # display the biggest files
alias lso="ls -alG | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'" # octal

alias rg=ranger

# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias chmodx='chmod --preserve-root u+x'

# Get external IP
alias myip="curl -s http://icanhazip.com"
alias myip4="dig A +short myip.opendns.com @resolver1.opendns.com"
alias myip6="curl -s6 http://icanhazip.com"

alias lw='loadwatch -l 1 -h 2.5 --'

# Copy-paste friendly mtr output
alias mtrp="mtr -rwc 5"

# udiskctl mount/unmount for block devices
alias udmount="udisksctl mount -b"
alias udumount="udisksctl unmount -b"

# task
alias t='task'
alias ta='task add'

# emerge
alias ems='emerge -s'
alias emS='emerge --searchdesc'

# qemu-img with progress bar
alias qemu-img='qemu-img -p'

# xzip extreme compression
alias xzec='xz -9ev --no-adjust'

# docker
alias dps='docker ps -lq'

