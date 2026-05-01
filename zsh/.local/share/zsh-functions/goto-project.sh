goto_project() {
  cd "$(fd . ~/Projects -d 2 -t d | fzf)"
  zle reset-prompt
}
zle -N goto_project
bindkey '^f' goto_project
