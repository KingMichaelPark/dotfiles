# Ensure path entries remain unique
typeset -U path PATH

pathmunge() {
    [[ -d "$1" ]] || return
    if [[ "$2" == "after" ]]; then
        path+=("$1")
    else
        path=("$1" $path)
    fi
}

### Add custom paths
for p in "$HOME/.local/bin" "/opt/homebrew/bin" "$HOME/.cargo/bin" "$HOME/.local/share/mise/shims"; do
    pathmunge "$p"
done

export XDG_CONFIG_HOME="$HOME/.config"
export SUDO_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim
export HOMEBREW_NO_ENV_HINTS=1
