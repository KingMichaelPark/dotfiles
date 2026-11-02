goto_project() {
  local dir
  dir=$(fd . ~/Projects -d 2 -t d | fzf --delimiter='/' --with-nth='-2')
  dir="${dir%/}"

  if [[ -n "$dir" ]]; then
    builtin cd -- "$dir" || return
    local session_name="${dir:t}"
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
