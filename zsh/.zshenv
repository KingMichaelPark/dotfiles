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
paths_to_append=("$HOME/.local/bin" "/opt/homebrew/bin" "$HOME/.cargo/bin" "/Library/PostgreSQL/16/bin")
for p in "${paths_to_append[@]}"; do
    if [ -d "$p" ]; then
        pathmunge "$p"
    fi
done


# Environmental Variables
# Bat Config
export MANPAGER="sh -c 'sed -e s/.\\\\x08//g | bat -l man -p'"
export BAT_THEME="base16" # bat cache --build
# Config Mac OS
export XDG_CONFIG_HOME="$HOME/.config"

# NNN Config
export NNN_FIFO=/tmp/nnn.fifo
export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
export NNN_PLUG='p:preview-tui;d:diffs;t:nmount;v:imgview'

export SUDO_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="
    --color=fg:#908caa,bg:,hl:#ea9a97
    --color=fg+:#e0def4,bg+:,hl+:#ea9a97
    --color=border:#44415a,header:#3e8fb0,gutter:#232136
    --color=spinner:#f6c177,info:#9ccfd8
    --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
     --multi
    --reverse --info=hidden"

# Aliases
alias cat="bat -p"
alias d=nerdctl
alias n='nerdctl'
alias k=kubectl
alias l='eza'
alias ls='eza'
alias la='l -a'                         # Short, all files
alias lC='la --sort=changed'            # Long, sort changed
alias lM='la --sort=modified'           # Long, sort modified
alias lS='la --sort=size'               # Long, sort size
alias lX='la --sort=extension'          # Long, sort extension
alias ll='l -lbG'                      # Long, file size prefixes, grid, git status
alias lA='ll -la'                       # Long, all files
alias lg=lazygit
alias nerd='nerdctl'
alias tf=terraform
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias x=xplr

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
