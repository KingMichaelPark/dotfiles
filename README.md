# My Dotfiles

![Github tag (latest by SemVer)](https://img.shields.io/github/v/tag/kingmichaelpark/dotfiles?style=flat-square)
![Mastodon Follow](https://img.shields.io/mastodon/follow/109638370673707754?domain=https%3A%2F%2Ffosstodon.org&style=social)

Everything is managed via gnu stow. The tl;dr is that relative to the dotfiles
directory (that you should clone to `~/.dotfiles` it will symlink the directory
you name up one directory. Different python, node, terraform versions are all
managed with [mise](https://github.com/jdxcode/mise)

For example, zsh/ contains `.zshrc` so to deploy your
zsh folder using `stow` you simply run

```bash
stow zsh
```

and for neovim

```bash
stow nvim
```

Creates the symlinks all the way to `~/.config/nvim/*`

## Required Software

- Age (Encryption)
- Bat (better cat alternative with syntax highlighting)
- Colima (Docker)
- Eza (prettier ls alternative)
- FD (faster find)
- FZF (fuzzy find files, commands, anything...)
- Git-Delta (better git diffs)
- Jq (json query)
- Lazygit (git tui)
- Mise (Manage all programming language versions and env vars)
- Neovim (text editor)
- nnn (Terminal file manager)
- Pnpm (faster node installs)
- Restic (online backups)
- Ripgrep (faster grep)
- Rsync (local backup to external hard drive)
- Stow (manage dotfile symlinks)
- Tmux (Shell multiplexer)

- Zoxide (Faster smart cd)
- Z-init (ZSH plugin manager)

### Install via Brew

Only use the mise commands if you want python and nodejs on your system.

```zsh
brew install \
    age \
    bat \
    colima \
    eza \
    fd \
    fzf \
    git-delta \
    jq \
    lazygit \
    mise \
    neovim \
    nnn \
    pnpm \
    restic \
    ripgrep \
    rsync \
    starship \
    stow \
    tmux \
    zoxide

cd ~/.dotfiles
stow mise
mise install nodejs python
```

To set environmental variables like `direnv`, in your project
use `mise env-vars KEY=VALUE` as mise can replace `direnv` for
these environmental variables loading.

## Different Modules

### [Backups](./backups)

- Online via Restic + Backblaze
- Offline via Rsync + Age

### [Fonts](./fonts/.local/share/fonts)

- Nerd Font Patched version of [Iosevka](https://typeof.net/Iosevka/) and [Pragmata Pro](https://github.com/fabrizioschiavi/pragmatapro) fusion
  called Mikevka (original... I know)

### FZF

Auto complete for the shell settings for fzf

### [Neovim](./nvim/.config/nvim)

My Neovim config with all plugins and settings

### [Starship](./starship/.config/starship/starship.toml)

Simple tweaks for the [starship.rs](https://starship.rs/) theme for zsh

### Mise

Using Mise can be done seeing `mise --help`

To set your project to automatically activate a virtualenv when switching to it
create a `.mise.toml` in your project directory and add.

```toml
python = {version="latest", virtualenv=".venv"}
```

### [Tmux](./tmux/)

Tmux settings

### [Wezterm](./wezterm/.config/wezterm)

Wezterm terminal

## Questions

If you have any questions send me a message at [Mastodon]("https://fosstodon.org/@mdawg")
