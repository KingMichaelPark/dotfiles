# Tool Initialization
eval "$(mise activate zsh)"

# Cache-based initialization invalidated automatically when binary updates
_cached_source() {
    local name="$1" bin="$2"
    shift 2
    [[ -n "$bin" ]] || return 0
    local cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/${name}.zsh"
    if [[ ! -f "$cache" || "$bin" -nt "$cache" ]]; then
        mkdir -p "${cache:h}"
        "$@" >| "$cache"
        zcompile "$cache"
    fi
    source "$cache"
}

_cached_source fzf    "$commands[fzf]"    fzf --zsh
_cached_source jj     "$commands[jj]"     env COMPLETE=zsh jj
_cached_source zoxide "$commands[zoxide]" zoxide init zsh
_cached_source atuin  "$commands[atuin]"  atuin init zsh --disable-up-arrow

unfunction _cached_source
