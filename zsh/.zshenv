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
for p in "$HOME/.local/bin" "/opt/homebrew/bin" "$HOME/.cargo/bin"; do
    pathmunge "$p"
done

# Load environment variables that should be available to non-interactive shells
source "$HOME/.local/share/zsh-functions/core/env.zsh"
