HISTSIZE=50000
SAVEHIST=50000

bindkey -v
export KEYTIMEOUT=1

# Allow backspace past insert point in vi insert mode
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char

# Edit command line in $EDITOR with 'v' in vi normal mode
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

# The file to save the history in.
if (( ! ${+HISTFILE} )) typeset -g HISTFILE=${ZDOTDIR:-${HOME}}/.zsh_history

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt EXTENDED_GLOB
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
setopt INTERACTIVE_COMMENTS
setopt NO_CLOBBER
setopt SHARE_HISTORY
# Disable the highlight formatting of pasted text (clashes with themes)
zle_highlight+=(paste:none)

# Increase max open files (file descriptors)
ulimit -n 8192
