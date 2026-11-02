# Plugin Manager
declare -A ZINIT
ZINIT[NO_ALIASES]=1
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light Aloxaf/fzf-tab

zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid atinit"zicdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting

# Starship
if [[ "$TERM" != "dumb" ]]; then
    zinit ice as"command" from"gh-r" \
              atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
              atpull"%atclone" src"init.zsh"
    zinit light starship/starship
fi
