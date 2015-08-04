# Basic directory operations
alias ...='cd ../..'
alias -- -='cd -'

# redirections
alias -g GP='|grep -i'
alias -g NL='> /dev/null'

# List direcory contents
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'
alias lh='ls -lh'
alias la='ls -lA'

alias rr=ranger
alias sprunge='pastebinit -b sprunge.us'

# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Get external IP
alias myip="curl -s http://icanhazip.com"
alias myip4="dig A +short myip.opendns.com @resolver1.opendns.com"
alias myip6="curl -s6 http://icanhazip.com"

alias lw='loadwatch -l 1 -h 2.5 --'

# Copy-paste friendly mtr output
alias mtrp="mtr -rwc 5"
