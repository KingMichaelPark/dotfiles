ji() {
    local args="$*"
    sops exec-env "$HOME/.dotfiles/a.age.json" "jira $args"
}
