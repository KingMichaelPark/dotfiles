ai() {
    local cmd="omp"
    if [[ "$PWD" == */vr/* || "$PWD" == */vr ]]; then
        cmd="claude"
    elif [[ ${(L)PWD} == *personal* ]]; then
        cmd="agy"
    fi
    sops exec-env "$HOME/.dotfiles/a.age.json" "$cmd${1:+ ${(q)@}}"
}
