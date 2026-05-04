autoload -Uz compinit; compinit

# Load core configuration modules
for module in options plugins styles tools aliases; do
    source "$HOME/.local/share/zsh-functions/core/$module.zsh"
done


# Load custom functions
for p in "$HOME/.local/share/zsh-functions/functions/"*.zsh(N); do
    source "$p"
done

