# run a command until it succeeds
function retry {
  local -i MAX_TRIES=999
  trap break INT
  for i in {1..$MAX_TRIES}; do
    $@ && break || printf '\x1b[33;01mretrying\x1b[39;49;00m (%d)\n' $i && sleep 5
  done
}

# remove current working directory recursively
function rmwd {
  local WORKING_DIR=$(pwd)
  local FILES_COUNT=$(ls -Af1 $WORKING_DIR | wc -l)

  read -q "REPLY?Remove ${WORKING_DIR} (${FILES_COUNT} files or more)? " || return
  printf '\n'
  cd .. \
    && rm -rvf -- "$WORKING_DIR"
}

# cd to a directory, creating if it doesn't exist
function take() {
  [ ! -e "$1" ] && mkdir -pv "$1"
  cd "$1"
}

# utimer countdown with bell
function utimerc() {
  utimer -c $1 && play -q /usr/share/sounds/freedesktop/stereo/complete.oga
}

# git
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function eeb() {
  $EDITOR "/usr/portage/$1"
}

# clones all repos in a github org
function gh_org_clone() {
  local username=$1 org=$2
  curl -u "${username}" -s "https://api.github.com/orgs/${org}/repos?per_page=200" | ruby -rubygems -e 'require "json"; JSON.load(STDIN.read).each { |repo| %x[git clone #{repo["ssh_url"]} ]}'
}

# vim-like abbreviations
# taken from:
# http://zshwiki.org/home/examples/zleiab
typeset -Ag abbreviations

abbreviations=(
  'Ia'   '| awk'
  'Il'   '| less'
  'Im'   '| more'
  'Ig'   '| grep'
  'Ieg'  '| egrep'
  'Iag'  '| agrep'
  'Igr'  '| groff -s -p -t -e -Tlatin1 -mandoc'
  'Ip'   "| $PAGER"
  'Ih'   '| head'
  'Ik'   '| keep'
  'It'   '| tail'
  'Is'   '| sort'
  'Iv'   "| ${VISUAL:-${EDITOR}}"
  'Iw'   '| wc'
  'Ix'   '| xargs'

  'TX'   'tar xvf'
  'TC'   'tar cvf'

  'Um'   'udisksctl mount'
  'Us'   'udisksctl status'
  'Uu'   'udisksctl unmount'

  'Agi'  'sudo apt-get install'
  'Agr'  'sudo apt-get remove'
  'Agu'  'sudo apt-get update'
  'Acp'  'apt-cache policy'
  'Acs'  'apt-cache search'
)

magic-abbrev-expand() {
     local left prefix
     left=$(echo -nE "$LBUFFER" | sed -e "s/[_a-zA-Z0-9]*$//")
     prefix=$(echo -nE "$LBUFFER" | sed -e "s/.*[^_a-zA-Z0-9]\([_a-zA-Z0-9]*\)$/\1/")
     LBUFFER=$left${abbreviations[$prefix]:-$prefix}" "
}

no-magic-abbrev-expand() {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand
bindkey -M isearch " " self-insert
