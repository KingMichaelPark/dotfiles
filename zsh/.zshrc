# Plugin Manager

declare -A ZINIT
ZINIT[NO_ALIASES]=1
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz compinit; compinit

# Plugins
zinit light Aloxaf/fzf-tab
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zinit light zdharma-continuum/fast-syntax-highlighting
fast-theme XDG:catppuccin-mocha -q
zinit light zsh-users/zsh-autosuggestions


# Starship
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship


zstyle ':fzf-tab:complete:*' fzf-bindings 'shift-tab:toggle'
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' continuous-trigger '`'

source <(fzf --zsh)
source <(COMPLETE=zsh jj)

eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"
