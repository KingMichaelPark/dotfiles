# Fast compinit: rebuild dump at most once every 24h
autoload -Uz compinit
() {
    if [[ ! -f $1 || -n $2 ]]; then
        compinit
        zcompile "$1"
    else
        compinit -C
    fi
} "${ZDOTDIR:-$HOME}/.zcompdump" ${ZDOTDIR:-$HOME}/.zcompdump(N.mh+24)

# Load core configuration modules (tools before plugins so fzf-tab wraps widgets properly)
for module in env options tools; do
    source "$HOME/.local/share/zsh-functions/core/$module.zsh"
done

# Load custom functions before syntax-highlighting/autosuggestions wrap ZLE widgets
for p in "$HOME/.local/share/zsh-functions/functions/"*.zsh(N); do
    source "$p"
done

for module in plugins styles aliases; do
    source "$HOME/.local/share/zsh-functions/core/$module.zsh"
done
