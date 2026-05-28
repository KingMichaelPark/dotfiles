ji() {
    local args="$*"
    sops exec-env "$HOME/.dotfiles/access.age.json" "jira $args"
}
