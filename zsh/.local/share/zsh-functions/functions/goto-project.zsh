goto_project() {
  local dir
  dir=$(fd . ~/Projects -d 2 -t d | fzf --delimiter='/' --with-nth='-2')
  dir="${dir%/}"

  if [[ -n "$dir" ]]; then
    local session_name="${dir:t}"
    local session_id
    session_id=$(rex session list --json | jq -r --arg label "$session_name" 'first(.sessions[] | select(.label == $label) | .session_id) // empty')

    if [[ -z "$session_id" ]]; then
      session_id=$(rex session new "$session_name" -c "$dir" --json | jq -r '.session_id')
    fi

    if [[ -n "$session_id" ]]; then
      rex do session.select "session_id=$session_id" >/dev/null
    fi
  fi

  if zle; then
    zle reset-prompt
  fi
}
zle -N goto_project
bindkey '^f' goto_project
bindkey -M vicmd '^f' goto_project
