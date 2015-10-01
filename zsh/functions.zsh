function rmwd {
  local d=$(pwd)
  cd ..
  rm -rvf -- "$d"
}
