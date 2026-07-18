goto_project() {
  local dir
  dir=$(fd . ~/Projects -d 2 -t d | sed 's#/$##' | fzf --delimiter='/' --with-nth='-1')
  
  if [[ -n "$dir" ]]; then
    cd "$dir"
    local session_name
    session_name=$(basename "$dir")
    if zle; then
      BUFFER="zmx a ${(q)session_name}"
      zle accept-line
    else
      zmx a "$session_name"
    fi
  else
    if zle; then
      zle reset-prompt
    fi
  fi
}
zle -N goto_project
bindkey '^f' goto_project
