{
  description = "My system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
    let
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages =
          [
            pkgs.fd
            pkgs.jq
            pkgs.neovim
            pkgs.ripgrep
          ];
        services.nix-daemon.enable = true;
        nix.settings.experimental-features = "nix-command flakes";
        programs.zsh.enable = true; # default shell on catalina
        system.configurationRevision = self.rev or self.dirtyRev or null;
        system.stateVersion = 4;
        nixpkgs.hostPlatform = nixpkgs.system;
        security.pam.enableSudoTouchIdAuth = true;

        users.users.${builtins.getEnv "USER"}.home = if pkgs.stdenv.isDarwin then "/Users/${builtins.getEnv "USER"}" else "/home/${builtins.getEnv "USER"}";
        home-manager.backupFileExtension = "backup";
        nix.configureBuildUsers = true;
        nix.useDaemon = true;

        system.defaults = {
          dock.autohide = true;
        };

        # Homebrew needs to be installed on its own!
        homebrew.enable = true;
        homebrew.casks = [
          "firefox"
          "spotify"
          "wezterm"
        ];
        homebrew.brews = [
        ];
      };
    in
    {
      {
      {
      darwinConfigurations."${builtins.getEnv "HOSTNAME"}" = nix-darwin.lib.darwinSystem {
        system = nixpkgs.system;
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${builtins.getEnv "USER"} = import ./home.nix;
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."${builtins.getEnv "HOSTNAME"}".pkgs;
    };
}
