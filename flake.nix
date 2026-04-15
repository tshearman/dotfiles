{
  description = "Example nix-darwin system flake";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nixpkgs.url = "github:NixOS/nixpkgs/ae67888ff7ef9dff69b3cf0cc0fbfbcd3a722abe"; # pinned: nixpkgs-unstable before VSCode 1.115.0 glibc.bin bug
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    nuenv = {
      url = "https://flakehub.com/f/DeterminateSystems/nuenv/0.1.*";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      mac-app-util,
      nix-vscode-extensions,
      nuenv,
      sops-nix,
      ...
    }:
    let
      me = import ./system/users/me.nix { };
      mac-modules = import ./system/macos {
        inherit me home-manager mac-app-util nix-vscode-extensions nuenv sops-nix;
      };

    in
    {
      darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem { modules = mac-modules; };
    };
}
