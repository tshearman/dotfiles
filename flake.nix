{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, nix-darwin, home-manager, ... }:
  let
    user.name = "toby";
    unfree-packages = [
      "discord"
      "obsidian"
      "vscode"
      "vscode-extension-mhutchie-git-graph"
      "spotify"
    ];
    darwinconf = { pkgs, lib, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) unfree-packages;
      nix.enable = false;
      users.knownUsers = [ user.name ];
      users.users."${user.name}" = {
        name = user.name;
        home = "/Users/${user.name}";
        packages = with pkgs; [
          btop
          discord
          git
          just
          kitty
          lazygit
          obsidian
          psutils
          spotify
          tldr
        ];
        uid = 501;
        shell = pkgs.fish;
      };
      programs.fish.enable = true;
      system = import ./macos.nix { inherit pkgs user; };
      homebrew = import ./homebrew.nix { inherit pkgs; };
      time.timeZone = "America/Detroit";
      security.pam.services.sudo_local.touchIdAuth = true;
    };
    
    homeconf = { pkgs, home-manager, ... }: {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "bkup";
      home-manager.users."${user.name}" = {
        programs = import ./programs.nix { inherit pkgs; };
        home.stateVersion = "23.05";
      };
    };

  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild switch --flake ~/.config/nix/#macbook
    darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
      modules = [ 
        darwinconf
        home-manager.darwinModules.home-manager
        homeconf 
      ];
    };
  };
}
