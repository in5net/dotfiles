{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          nixpkgs.config.allowUnfree = true;

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = with pkgs; [
            curl
            wget
            cmake
            fish
            git
            delta
            fzf
            fd
            ripgrep
            gnused
            sd
            tmux
            sesh
            neovim
            ansible
            fortune
            ffmpeg
            jq
            lazygit
            lazydocker
            eza
            bat
            zoxide
            yadm
            yt-dlp
            tlrc
            hexyl
            darwin.trash
            gum
            stripe-cli
            jdk
            sqlite
            bun
            pnpm
            fnm
            deno
            google-cloud-sdk
            google-cloud-sql-proxy
            uv
            unar
            nixfmt-rfc-style
            yazi
            kakoune
            rustup
            go
            miniserve
          ];

          homebrew = {
            enable = true;
            brews = [
              "colima"
              "docker"
              "docker-credential-helper"
              "mecab-ipadic"
            ];
            casks = [
              "amethyst"
              "anki"
              "calibre"
              "firefox"
              "git-credential-manager"
              "google-chrome"
              "iterm2"
              "jordanbaird-ice"
              "tableplus"
              "hakuneko"
              "onedrive"
              "google-japanese-ime"
              "spotify"
              "raycast"
              "discord"
              "iina"
              "stats"
              "appcleaner"
              "protonvpn"
              "musescore"
            ];
            masApps = {
              "QuickShade" = 931571202;
            };
            onActivation.cleanup = "zap";
          };

          fonts.packages = with pkgs; [
            nerd-fonts.fira-code
          ];

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#m1
      darwinConfigurations."m1" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "izaak";

              # Automatically migrate existing Homebrew installations
              autoMigrate = true;
            };
          }
        ];
      };
    };
}
