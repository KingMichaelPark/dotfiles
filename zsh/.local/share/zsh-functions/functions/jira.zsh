ji() {
    sops exec-env "$HOME/.dotfiles/a.age.json" "jira${1:+ ${(q)@}}"
}
