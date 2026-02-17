# My Dotfiles

![Github tag (latest by SemVer)](https://img.shields.io/github/v/tag/kingmichaelpark/dotfiles?style=flat-square)
![Mastodon Follow](https://img.shields.io/mastodon/follow/109638370673707754?domain=https%3A%2F%2Ffosstodon.org&style=social)
[![Bluesky Follow](https://img.shields.io/bluesky/follow/mhpark.me?style=social)](https://bsky.app/profile/mhpark.me)

Dotfiles are managed via `gnu stow`. From `~/.dotfiles`, `stow <dir>` symlinks
its contents to the parent directory. Tooling (Python, Node, etc.) is managed
via [mise](https://github.com/jdxcode/mise).

**Example:**

```bash
stow zsh   # Symlinks .zshrc
stow nvim  # Symlinks ~/.config/nvim/
```

## Essential Software

This is a list of software I use all the time and wouldn't be as productive
without it, feel free to pick and choose what you like.

### Software & Tools

| Software            | Description                                                              |
| :------------------ | :----------------------------------------------------------------------- |
| **age**             | Simple, modern, secure file encryption                                   |
| **agg**             | Convert asciinema recordings to gif                                      |
| **argon2**          | Password hashing library and CLI utility                                 |
| **asciinema**       | Terminal recording tool                                                  |
| **bat**             | Clone of cat(1) with syntax highlighting and Git integration             |
| **bottom**          | Yet another cross-platform graphical process/system monitor              |
| **colima**          | Docker cli free OSS                                                      |
| **docker**          | Docker and its related plugins/extensions (compose, buildx, etc.)        |
| **duckdb**          | Embeddable SQL OLAP Database Management System                           |
| **entr**            | Run arbitrary commands when files change                                 |
| **eza**             | Modern, maintained replacement for ls                                    |
| **fd**              | Simple, fast and user-friendly alternative to find                       |
| **fzf**             | Command-line fuzzy finder written in Go                                  |
| **gemini-cli**      | Google Gemini TUI for ai workflows                                       |
| **ghostty**         | Current terminal emulator                                                |
| **git**             | The apple system git is way too old                                      |
| **git-delta**       | Syntax-highlighting pager for git and diff output                        |
| **hurl**            | HTTP Tool                                                                |
| **jq**              | Lightweight and flexible command-line JSON processor                     |
| **jj**              | VCS alternative to git but also git compatible (Jujutsu)                 |
| **jjui**            | TUI for Jujutsu                                                          |
| **lazydocker**      | Simple terminal UI for docker commands                                   |
| **lazygit**         | Simple terminal UI for git commands                                      |
| **mise**            | Polyglot runtime manager (asdf rust clone)                               |
| **neovim**          | Ambitious Vim-fork focused on extensibility and agility                  |
| **pandoc**          | Swiss-army knife of markup format conversion                             |
| **prek**            | Pre-commit tool written in rust                                          |
| **tree-sitter**     | Syntax tree based highlighting for neovim                                |
| **tree-sitter-cli** | Install parsers for tree sitter                                          |
| **restic**          | Back-up utility with snapshots and backups                               |
| **ripgrep**         | Search tool like grep and The Silver Searcher                            |
| **sops**            | Editor of encrypted files                                                |
| **stow**            | Organize software neatly under a single directory tree (e.g. /usr/local) |
| **stylua**          | Opinionated Lua code formatter                                           |
| **typst**           | LaTeX / Word alternative                                                 |
| **uv**              | Extremely fast Python package installer and resolver, written in Rust    |
| **yazi**            | TUI file manager                                                         |
| **zoxide**          | Shell extension to navigate your filesystem faster                       |

### Installation

To install all essential software via Homebrew, run:

```bash
brew install age agg argon2 asciinema bat bottom colima docker docker-compose docker-buildx docker-credential-helper duckdb entr eza fd fzf git git-delta hurl jq jj jjui lazydocker lazygit mise neovim opencode pandoc prek tree-sitter tree-sitter-cli restic ripgrep sops stow stylua typst uv yazi zoxide && brew install --cask ghostty
```

### Fonts

Nerd Font Patched version of [Iosevka](https://typeof.net/Iosevka/)'s private
build plans are in the font directory. The latest version I build, I just
upload [here](https://drive.google.com/drive/folders/1UbV9Lk9jbUynyOmudZMBwd3Fygve76P2).

I also have a narrow build of [Maple Mono](https://github.com/subframe7536/maple-font) there.

## Questions

If you have any questions send me a message at [Mastodon]("https://fosstodon.org/@mdawg") or [Bluesky]("https://bsky.app/profile/mhpark.me")
