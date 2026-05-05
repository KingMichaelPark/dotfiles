ai() {
    sops exec-env "$HOME/.dotfiles/access.age.json" "opencode $@"
}
