function rmwd {
  local d=$(pwd)
  cd ..
  rm -rvf -- "$d"
}

#######################################
#                  GIT
#######################################
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}
