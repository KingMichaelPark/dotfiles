# Append Paths
pathmunge () {
        if ! echo "$PATH" | grep -Eq "(^|:)$1($|:)" ; then
           if [ "$2" = "after" ] ; then
              PATH="$PATH:$1"
           else
              PATH="$1:$PATH"
           fi
        fi
}

### Add custom paths
paths_to_append=("$HOME/.local/bin" "/opt/homebrew/bin" "$HOME/.cargo/bin")
for p in "${paths_to_append[@]}"; do
    if [ -d        "$p" ]; then
        pathmunge "$p"
    fi
done


# Environmental Variables
# Bat Config
export MANPAGER="sh -c 'sed -e s/.\\\\x08//g | bat -l man -p'"
export BAT_THEME="Catppuccin Mocha" # bat cache --build
# Config Mac OS
export EZA_CONFIG_DIR="$HOME/.config/eza"
export XDG_CONFIG_HOME="$HOME/.config"

# NNN Config
export NNN_FIFO=/tmp/nnn.fifo
export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
export NNN_PLUG='p:preview-tui;d:diffs;t:nmount;v:imgview'

export SUDO_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim

# FZF
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_COMMAND=""
export FZF_DEFAULT_OPTS="--multi --reverse --info=hidden \
--color=bg+:#1e1e2e,bg:,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--color=border:#313244,label:#cdd6f4"

export HOMEBREW_NO_ENV_HINTS=1

# Aliases
alias ai="sops exec-env ~/.dotfiles/access.json \"gemini\""
alias cat="bat -p"
alias d="docker"
alias dc="docker-compose"
alias gitlog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
alias j=just
alias k=kubectl
alias ld=lazydocker
alias lg=lazygit
alias ll=jjui
alias ls='eza'
alias n='nnn'
alias tf=terraform
alias v="nvim"
alias vim="nvim"
alias y="yazi"
# ZSH Settings
HISTSIZE=20000
SAVEHIST=10000

bindkey -v # Set editor default keymap to emacs (`-e`) or vi (`-v`)

# The file to save the history in.
if (( ! ${+HISTFILE} )) typeset -g HISTFILE=${ZDOTDIR:-${HOME}}/.zsh_history

setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE # Remove commands from the history that begin with a space.
setopt INTERACTIVE_COMMENTS # Allow comments starting with `#` in the interactive shell.
setopt NO_CLOBBER # Disallow `>` to overwrite existing files. Use `>|` or `>!` instead.
setopt SHARE_HISTORY # Cause all terminals to share the same history 'session'.

# Starship
export STARSHIP_LOG="error"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export BIOME_CONFIG_PATH="$HOME/.dotfiles/biome.jsonc"

goto_project() {
  cd "$(fd . ~/Projects -d 2 -t d | fzf)"
  zle reset-prompt
}
zle -N goto_project
bindkey '^f' goto_project

# Yazi
function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

## Project Specific Helpers
if [ -d "$HOME/Projects/oxford/toolbox/zsh_helpers" ]; then
    for file in $HOME/Projects/oxford/toolbox/zsh_helpers/*.zsh; do
        source $file;
    done;
fi
