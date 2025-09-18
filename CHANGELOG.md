## 2.0.0 (2025-04-13)

### Feat

- update lsp config to be more automatic
- grug-far
- tidy
- fzf.lua to snacks
- add sample of font as an image
- update theme for delta and git
- add smart close keymap
- update font to latest with minor character tweaks
- lazygit config
- switch to builtin lsp agent config
- update blink to 1.0
- add shortcut go to project as ctrl+f
- update lazygit style to diffsofancy
- add some aliases
- add dat dadbod shuffle
- update starship theme
- add new mapping for saving and quitting
- update style of tabs
- update to different access token
- remove atuin
- update font family to be a bit easier on the eyes
- finally get codecompanion working nicely
- update formatting for highlight-colors
- update atuin settings
- switch to kanagawa theme!
- update to fzf lua and lazygit instead
- remove jj
- update config for atuin
- add atuin for shell history
- update font family to final tweaks
- add more settings for jj
- update zsh with autocomplete for jj
- update models to use gemini as it's cheaper

### Fix

- codecompanion
- gemini setup for API keys
- shortcut for git_files and files
- move git config to git instead of lazygit
- Park -> Hunter && fix keymap for neovim quit
- update default file picker to git picker
- mappings for lsp error messages
- update the fzf.lua ignore patterns
- make terminal ever so slightly blue black
- jj config
- rev to cat
- lualine show relative path
- mapping for send to quickfix
- colors for background
- invert the UI
- mappings for AI
- tidy starship info

## 1.9.0 (2025-02-06)

### Feat

- slight tweaks
- update ai plugin to use codecompanion
- revert codecompanion
- update font 0 character
- switch to basedpyright for more features
- remove unnecessary plugin
- let's try snacks out for fuzzy picking
- add updated custom font as Park Nerd Font
- add highlight colors back in
- update config
- lazygit config
- add some more mappings for code comapnion
- add mappings for code companion
- switch to codecompanion
- add config for ghostty avante and cleanup lualine
- update config to fit a larger screen and add reload config option
- add ghostty config
- update blink config
- sane defaults for previewer in fzf
- update docs to use fzf.lua and latest anthropic
- background less blue
- wezterm sessioniser update
- update blink config to actually work correctly
- stick to git for now
- add delta as jj pager
- update default email address
- add jj config
- add jj config
- update lazy mapping
- add colima config and dashboard
- add colima config
- update readme
- update treesitter config
- Bump Mikevka to latest Iosevka version
- fix cmp and update font config
- update mappings to have better error message handling
- pure
- add full path to lualine
- remove unused plugins
- add alias for yazi and set line height in wezterm
- cmp using blink
- Update font family to latest release and set correct line height

### Fix

- add a wrapper around the git repo call
- codecompanion command
- mappings
- picker shortcuts in snacks.nvim
- Park ' character
- delta diff colors
- grep options to include hidden files
- lsp config setup for pyright and ruff
- update buf formatting logic
- lsp
- remove duplicate linter config
- fzf completion
- telescope mappings
- update telescope options
- remove aliases
- zinit shortcut
- lualine formatting
- cloak
- line height
- tidy up file formatting and remove nnn plugins

## 1.6.0 (2024-10-27)

### Feat

- tidy, format and update everything to Catppuccin
- use uv for python package resolution
- delete .cz.yaml
- don't need to source control colima
- add rose-pine theme for autumn vibes
- add avante custom prompts
- update cmp appearance

### Fix

- avante quality prompts
- lazygit highlighting
- add settings for my PR for mason to use uv
- diffview mappings

## 1.5.0 (2024-10-04)

### Feat

- add wezterm sessioniser and keymaps
- add avante to use anthropic instead of openai
- add more treesitter text objects
- use uv via my fork for mason.nvim

### Fix

- make background slightly darker
- add additional ligatures to font

## 1.4.0 (2024-09-11)

### Feat

- add update font version to latest nerd and iosevka releases
- add kulala http client
- add avante.nvim plugin
- faster previewer
- switch gpt model to 4o-mini
- bump fonts
- add some nnn plugins so I can get image previews
- Add tmux mappings for wezterm
- add gopls language server
- catppuccin bat and delta
- switch to ruff server from ruff_lsp
- Add colorhints
- Update to neovim 0.10.0 features
- switch to mini surround
- update config to optimise python and js files

### Fix

- lazygit delta argument configuration
- tsserver -> ts_ls
- lazygit config
- tidy catppuccin to make it cleaner
- slightly warmer background palette
- remove avante, stole code
- remove webdevicons from oil as I never use them
- lsp autoformat for biome
- which-key
- highlight colors fzf
- typo
- online backup script
- mappings for tabs
- tab function in wezterm shortcut
- remove conceal layer
- remove comment inlays until required
- sql comments in neovim 0.10.0
- update gitignore
- lazy load all the things!
- update token length
- update access for chatgpt
- mini surround mappings
- mini setup
- lsp.lua icons (#1)
- update inlay_hints and icons for 0.10.0
- lspconfig opts usage
- update splash art

## 1.2.0 (2024-04-03)

### Feat

- update starship prompt
- update font to latest iosevka
- switch to orgmode instead of neorg
- Add dadbod-ui for sql queries
- add todo.lua
- update telescope mappings
- add .cargo/bin
- catppuccinn bat and transparency
- add treesitter highlights for Jenkins and tfvars
- xplr
- tmux theme
- add copilot but disable

### Fix

- python starship spacing
- cleanup unused plugins add ts for used languages
- lazygit add color theme for catppuccin
- update dap ui mappings
- update fzf script
- terminal theme changes
- make telescope great again
- conform.lua rules for import sorting
- add ui select
- cat
- neorg
- trim trailing whitespace
- unify tmux and lualine
- update wezterm features to add spaces
- mappings for moving text
- ignore zprofile
- ignore zprofile
- # sign fix for macos

## 1.1.0 (2024-01-22)

### Feat

- add yazi fm
- Add nvim-lint for servers without lsp
- switch to toggleterm
- mikevka 28.0.4 Iosekva Base

### Fix

- tmux prefix key back to normal
- cmp mappings for command mode
- alpha
- Update mason.lua
- Update lsp.lua
- conform formatting

## 1.0.2 (2024-01-07)

### Fix

- tidy cmp and unused plugins

## 1.0.1 (2024-01-06)

### Feat

- lazify neovim to start quicker
- rust-tools -> rustacean

### Fix

- tmux to minimal style
- catppuccin theme
- include font

## 1.0.0 (2023-12-10)

### Feat

- initial commit
