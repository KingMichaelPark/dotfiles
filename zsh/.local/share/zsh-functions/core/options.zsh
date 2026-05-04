HISTSIZE=20000
SAVEHIST=10000

bindkey -v

# The file to save the history in.
if (( ! ${+HISTFILE} )) typeset -g HISTFILE=${ZDOTDIR:-${HOME}}/.zsh_history

setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt INTERACTIVE_COMMENTS
setopt NO_CLOBBER
setopt SHARE_HISTORY
