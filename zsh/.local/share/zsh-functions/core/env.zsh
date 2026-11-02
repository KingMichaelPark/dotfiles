# Environmental Variables
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Bat Config
export MANPAGER="sh -c 'sed -e s/.\\\\x08//g | bat -l man -p'"
export BAT_THEME="Rose-Pine"

# Config Mac OS
export EZA_CONFIG_DIR="$HOME/.config/eza"
# FZF
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_COMMAND=""
export FZF_DEFAULT_OPTS="--multi --reverse --info=hidden \
	--color=fg:#908caa,bg:,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

# Starship
export STARSHIP_LOG="error"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
