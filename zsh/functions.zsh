function rmwd {
  local d=$(pwd)
  cd ..
  rm -rvf -- "$d"
}

function take() {
  [ ! -e "$1" ] && mkdir -pv "$1"
  cd "$1"
}

#######################################
#                  GIT
#######################################
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}
