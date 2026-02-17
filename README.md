# My Dotfiles

![Mastodon Follow](https://img.shields.io/mastodon/follow/109638370673707754?domain=https%3A%2F%2Ffosstodon.org&style=social)
![Bluesky Follow](https://img.shields.io/bluesky/followers/mhpark.me)

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

| Software                                                          | Description                                                              |
| :---------------------------------------------------------------- | :----------------------------------------------------------------------- |
| [**age**](https://github.com/FiloSottile/age)                     | Simple, modern, secure file encryption                                   |
| [**agg**](https://github.com/asciinema/agg)                       | Convert asciinema recordings to gif                                      |
| [**argon2**](https://github.com/P-H-C/phc-winner-argon2)          | Password hashing library and CLI utility                                 |
| [**asciinema**](https://github.com/asciinema/asciinema)           | Terminal recording tool                                                  |
| [**bat**](https://github.com/sharkdp/bat)                         | Clone of cat(1) with syntax highlighting and Git integration             |
| [**bottom**](https://github.com/ClementTsang/bottom)              | Yet another cross-platform graphical process/system monitor              |
| [**colima**](https://github.com/abiosoft/colima)                  | Docker cli free OSS                                                      |
| [**docker**](https://github.com/docker/cli)                       | Docker and its related plugins/extensions (compose, buildx, etc.)        |
| [**duckdb**](https://github.com/duckdb/duckdb)                    | Embeddable SQL OLAP Database Management System                           |
| [**entr**](https://github.com/eradman/entr)                       | Run arbitrary commands when files change                                 |
| [**eza**](https://github.com/eza-community/eza)                   | Modern, maintained replacement for ls                                    |
| [**fd**](https://github.com/sharkdp/fd)                           | Simple, fast and user-friendly alternative to find                       |
| [**fzf**](https://github.com/junegunn/fzf)                        | Command-line fuzzy finder written in Go                                  |
| [**gemini-cli**](https://github.com/google-gemini/gemini-cli)     | Google Gemini TUI for ai workflows                                       |
| [**ghostty**](https://github.com/ghostty-org/ghostty)             | Current terminal emulator                                                |
| [**git**](https://github.com/git/git)                             | The apple system git is way too old                                      |
| [**git-delta**](https://github.com/dandavison/delta)              | Syntax-highlighting pager for git and diff output                        |
| [**hurl**](https://github.com/Orange-OpenSource/hurl)             | HTTP Tool                                                                |
| [**jq**](https://github.com/jqlang/jq)                            | Lightweight and flexible command-line JSON processor                     |
| [**jj**](https://github.com/martinvonz/jj)                        | VCS alternative to git but also git compatible (Jujutsu)                 |
| [**jjui**](https://github.com/idursun/jjui)                       | TUI for Jujutsu                                                          |
| [**lazydocker**](https://github.com/jesseduffield/lazydocker)     | Simple terminal UI for docker commands                                   |
| [**lazygit**](https://github.com/jesseduffield/lazygit)           | Simple terminal UI for git commands                                      |
| [**mise**](https://github.com/jdx/mise)                           | Polyglot runtime manager (asdf rust clone)                               |
| [**neovim**](https://github.com/neovim/neovim)                    | Ambitious Vim-fork focused on extensibility and agility                  |
| [**pandoc**](https://github.com/jgm/pandoc)                       | Swiss-army knife of markup format conversion                             |
| [**prek**](https://github.com/j178/prek)                          | Pre-commit tool written in rust                                          |
| [**tree-sitter**](https://github.com/tree-sitter/tree-sitter)     | Syntax tree based highlighting for neovim                                |
| [**tree-sitter-cli**](https://github.com/tree-sitter/tree-sitter) | Install parsers for tree sitter                                          |
| [**restic**](https://github.com/restic/restic)                    | Back-up utility with snapshots and backups                               |
| [**ripgrep**](https://github.com/BurntSushi/ripgrep)              | Search tool like grep and The Silver Searcher                            |
| [**sops**](https://github.com/getsops/sops)                       | Editor of encrypted files                                                |
| [**stow**](https://www.gnu.org/software/stow/)                    | Organize software neatly under a single directory tree (e.g. /usr/local) |
| [**stylua**](https://github.com/JohnnyMorganz/StyLua)             | Opinionated Lua code formatter                                           |
| [**typst**](https://github.com/typst/typst)                       | LaTeX / Word alternative                                                 |
| [**uv**](https://github.com/astral-sh/uv)                         | Extremely fast Python package installer and resolver, written in Rust    |
| [**yazi**](https://github.com/sxyazi/yazi)                        | TUI file manager                                                         |
| [**zoxide**](https://github.com/ajeetdsouza/zoxide)               | Shell extension to navigate your filesystem faster                       |

### Installation

To install all essential software via [Homebrew](https://brew.sh/), run:

```bash
brew install age agg argon2 asciinema bat bottom colima docker docker-compose docker-buildx docker-credential-helper duckdb entr eza fd fzf git git-delta hurl jq jj jjui lazydocker lazygit mise neovim opencode pandoc prek tree-sitter tree-sitter-cli restic ripgrep sops stow stylua typst uv yazi zoxide && brew install --cask ghostty
```

### Fonts

Nerd Font Patched version of [Iosevka](https://typeof.net/Iosevka/)'s private
build plans are in the font directory. The latest version I build, I just
upload [here](https://drive.google.com/drive/folders/1UbV9Lk9jbUynyOmudZMBwd3Fygve76P2).

I also have a narrow build of [Maple Mono](https://github.com/subframe7536/maple-font) there.

## Questions

If you have any questions send me a message at [Mastodon](https://fosstodon.org/@mdawg) or [Bluesky](https://bsky.app/profile/mhpark.me)
