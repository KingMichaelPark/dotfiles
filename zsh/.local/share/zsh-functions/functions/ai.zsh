ai() {
    local args="$*"
    sops exec-env "$HOME/.dotfiles/access.age.json" "omp $args"
}
