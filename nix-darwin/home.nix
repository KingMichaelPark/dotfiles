{ config, pkgs, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${home.username}" else "/home/${home.username}";
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = [
    "bat"
    "bottom"
    "delta"
    "entr"
    "eza"
    "fzf"
    "imagemagick"
    "jujutsu"
    "lazygit"
    "mise"
    "nnn"
    "restic"
    "sops"
    "uv"
    "zoxide"
  ];

  home.file = {
    ".config/nix".source = ~/dotfiles/nix;
    ".config/nix-darwin".source = ~/dotfiles/nix-darwin;
    ".config/nvim".source = ~/dotfiles/nvim/.config/neovim;
    ".config/starship".source = ~/dotfiles/starship/.config/starship;
    ".config/tmux".source = ~/dotfiles/tmux;
    ".config/wezterm".source = ~/dotfiles/wezterm/.config/wezterm;
    ".zshenv".source = ~/dotfiles/zsh/.zshenv;
    ".zshrc".source = ~/dotfiles/zsh/.zshrc;
    # ".config/ghostty".source = ~/dotfiles/ghostty;
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };
}
