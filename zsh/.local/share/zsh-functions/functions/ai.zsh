ai() {
    local args="$*"
    local cmd="opencode"
    if [[ "$PWD" == */virgin/* || "$PWD" == */virgin ]]; then
        cmd="claude"
    fi
    sops exec-env "$HOME/.dotfiles/access.age.json" "$cmd $args"
}
