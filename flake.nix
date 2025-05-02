{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      user = import ./me.nix { };
      host-system = "aarch64-darwin";
      secrets = import ./secrets.nix { };
      darwinconf = { pkgs, lib, ... }: {
        environment.systemPackages = with pkgs; [ tailscale ];
        homebrew = import ./homebrew.nix { inherit pkgs; };
        nix.enable = false;
        nix.settings.experimental-features = "nix-command flakes";
        nixpkgs.hostPlatform = host-system;
        nixpkgs.config.allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) [
            "discord"
            "obsidian"
            "vscode"
            "vscode-extension-mhutchie-git-graph"
          ];
        programs.fish.enable = true;
        security.pam.services.sudo_local.touchIdAuth = true;
        services.tailscale.enable = true;
        system = import ./macos.nix { inherit pkgs user; };
        time.timeZone = "America/Detroit";
        users.knownUsers = [ user.user-name ];
        users.users."${user.user-name}" =
          import ./user.nix { inherit pkgs user; };
      };

      homeconf = { pkgs, home-manager, ... }: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "bkup";
        home-manager.users."${user.user-name}" = {
          programs = import ./home/programs.nix { inherit pkgs secrets; };
          home.packages = import ./home/packages.nix { inherit pkgs; };
          home.stateVersion = "23.05";
        };
      };

    in {
      # Build darwin flake using:
      # $ darwin-rebuild switch --flake ~/.config/nix/#macbook
      darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
        modules =
          [ darwinconf home-manager.darwinModules.home-manager homeconf ];
      };
    };
}
