function rmwd {
  local d=$(pwd)
  cd ..
  rm -rvf -- "$d"
}

function take() {
  [ ! -e "$1" ] && mkdir -pv "$1"
  cd "$1"
}

# git
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

# vim-like abbreviations
# taken from:
# http://zshwiki.org/home/examples/zleiab
typeset -Ag abbreviations

abbreviations=(
  "Ia"    "| awk"
  "Il"    "| less"
  "Im"    "| more"
  "Ig"    "| grep"
  "Ieg"   "| egrep"
  "Iag"   "| agrep"
  "Igr"   "| groff -s -p -t -e -Tlatin1 -mandoc"
  "Ip"    "| $PAGER"
  "Ih"    "| head"
  "Ik"    "| keep"
  "It"    "| tail"
  "Is"    "| sort"
  "Iv"    "| ${VISUAL:-${EDITOR}}"
  "Iw"    "| wc"
  "Ix"    "| xargs"
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
