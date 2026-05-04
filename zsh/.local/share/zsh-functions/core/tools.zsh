# Tool Initialization
# Cache-based initialization for speed
if [[ ! -f "$HOME/.fzf.zsh" ]]; then fzf --zsh > "$HOME/.fzf.zsh"; fi
source "$HOME/.fzf.zsh"

if [[ ! -f "$HOME/.jj.zsh" ]]; then COMPLETE=zsh jj > "$HOME/.jj.zsh"; fi
source "$HOME/.jj.zsh"

eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"
