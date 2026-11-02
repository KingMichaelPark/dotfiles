zmx-select() {
  local display
  display=$(zmx list 2>/dev/null | while IFS=$'\t' read -r name pid clients created dir; do
    name=${name#*name=}
    pid=${pid#*pid=}
    clients=${clients#*clients=}
    dir=${dir#*start_dir=}
    printf "%-20s  pid:%-8s  clients:%-2s  %s\n" "$name" "$pid" "$clients" "$dir"
  done)

  local output query key selected session_name action="attach"
  output=$({ [[ -n "$display" ]] && echo "$display"; } | fzf \
    --print-query \
    --expect=ctrl-n,ctrl-x \
    --no-multi \
    --height=80% \
    --reverse \
    --prompt="zmx> " \
    --header="Enter: attach | Ctrl-N: create new | Ctrl-X: kill" \
    --preview='zmx history {1}' \
    --preview-window=right:60%:follow \
  )
  local rc=$?

  local -a lines=("${(@f)output}")
  query="${lines[1]}"
  key="${lines[2]}"
  selected="${lines[3]}"

  if [[ "$key" == "ctrl-n" && -n "$query" ]]; then
    session_name="$query"
  elif [[ "$key" == "ctrl-x" && -n "$selected" ]]; then
    session_name="${selected%% *}"
    action="kill"
  elif [[ $rc -eq 0 && -n "$selected" ]]; then
    session_name="${selected%% *}"
  elif [[ $rc -eq 0 && -n "$query" ]]; then
    session_name="$query"
  else
    if zle; then
      zle reset-prompt
      zle redisplay
    fi
    return 130
  fi

  if zle; then
    BUFFER="zmx $action ${(q)session_name}"
    zle accept-line
  else
    zmx "$action" "$session_name"
  fi
}

zle -N zmx-select
bindkey '^p' zmx-select
