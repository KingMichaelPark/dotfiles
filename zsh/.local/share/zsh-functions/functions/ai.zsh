ai() {
    local args="$*"
    sops exec-env "$HOME/.dotfiles/access.age.json" "opencode $args"
}
