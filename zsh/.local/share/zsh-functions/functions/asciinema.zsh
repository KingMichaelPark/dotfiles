function record_session() {
  local filename="$(date +'%Y-%m-%d-%H-%M')"
  asciinema rec "$filename.cast"
  agg "$filename.cast" "$filename.gif"
}
alias rec='record_session'
