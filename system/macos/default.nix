{
  me,
  host-system,
  home-manager,
  mac-app-util,
  nix-vscode-extensions,
  sops-nix,
}:
let
  darwinconf =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        tailscale
        devenv
      ];
      system = import ./system.nix { inherit pkgs me; };
    };
in
[
  darwinconf
  mac-app-util.darwinModules.default
  home-manager.darwinModules.home-manager
  (import ../../home/homemanager {
    inherit me sops-nix;
    extraImports = [ mac-app-util.homeManagerModules.default ];
  })
  (import ../nix { inherit host-system nix-vscode-extensions; })
  ../fonts
  ../locale
  ../services
  ./services.nix
  ./homebrew
  (import ../users { inherit me; })
]
