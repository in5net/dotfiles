{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        curl
        wget
        cmake
        fish
        starship
        git
        delta
        fzf
        fd
        ripgrep
        tmux
        gitmux
        sesh
        neovim
        ansible
        fortune
        ffmpeg
        jq
        lazygit
        eza
        bat
        zoxide
        yadm
        yt-dlp
        tldr
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
        appcleaner
        iterm2
        iina
        mokuro
      ];

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
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#m1
    darwinConfigurations."m1" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
