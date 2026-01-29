{
  description = "Example nix-darwin system flake";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      mac-app-util,
      nix-vscode-extensions,
      sops-nix,
      ...
    }:
    let
      user = import ./me.nix { };
      host-system = "aarch64-darwin";

      darwinconf =
        { pkgs, lib, ... }:
        {
          environment.systemPackages = with pkgs; [
            tailscale
            devenv
          ];
          fonts.packages = [
            pkgs.nerd-fonts.fira-code
            pkgs.nerd-fonts.inconsolata
          ];
          homebrew = import ./home/homebrew.nix { inherit pkgs; };
          nix.enable = false;
          nix.settings.experimental-features = "nix-command flakes";
          nix.settings.trusted-users = [
            "root"
            "toby"
          ];
          nixpkgs.config.allowUnfreePredicate =
            pkg:
            builtins.elem (lib.getName pkg) [
              "discord"
              "obsidian"
              "vscode"
              "vscode-extension-anthropic-claude-code"
              "claude-code"
            ];
          nixpkgs.hostPlatform = host-system;
          nixpkgs.overlays = [ nix-vscode-extensions.overlays.default ];
          programs.fish.enable = true;
          programs.zsh.enable = true;
          security.pam.services.sudo_local.touchIdAuth = true;
          services.tailscale.enable = true;
          system = import ./macos.nix { inherit pkgs user; };
          time.timeZone = "America/Detroit";
          users.knownUsers = [ user.user-name ];
          users.users."${user.user-name}" = import ./user.nix { inherit pkgs user; };
        };

      homeconf =
        { pkgs, home-manager, ... }:
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bkup";
          home-manager.users."${user.user-name}" = {
            programs = import ./home/programs.nix { inherit pkgs user config; };
            home.packages = import ./home/packages.nix { inherit pkgs; };
            home.stateVersion = "23.05";
            imports = [
              mac-app-util.homeManagerModules.default
              sops-nix.homeManagerModules.sops
              ./home/sops.nix
            ];
          };
        };

      mac-modules = [
        mac-app-util.darwinModules.default
        darwinconf
        home-manager.darwinModules.home-manager
        homeconf
      ];

    in
    {
      darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem { modules = mac-modules; };
    };
}
