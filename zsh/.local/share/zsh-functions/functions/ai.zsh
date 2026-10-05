ai() {
    local args="$*"
    local cmd="opencode"
    if [[ "$PWD" == */vr/* || "$PWD" == */vr ]]; then
        cmd="claude"
    elif [[ ${(L)PWD} == *personal* ]]; then
        cmd="agy"
    else
        cmd="opencode"
    fi
    sops exec-env "$HOME/.dotfiles/access.age.json" "$cmd $args"
}
