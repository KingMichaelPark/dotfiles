# Environmental Variables
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Bat Config
export MANPAGER="sh -c 'sed -e s/.\\\\x08//g | bat -l man -p'"
export BAT_THEME="Catppuccin Mocha"

# Config Mac OS
export EZA_CONFIG_DIR="$HOME/.config/eza"
export XDG_CONFIG_HOME="$HOME/.config"
export LS_COLORS=$(cat "$HOME/.dotfiles/catppuccin.colors")

# Editors
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

# Starship
export STARSHIP_LOG="error"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
