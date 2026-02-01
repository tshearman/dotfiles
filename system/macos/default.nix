{
  me,
  home-manager,
  mac-app-util,
  nix-vscode-extensions,
  nuenv,
  sops-nix,
}:
let
  host-system = "aarch64-darwin";
  darwinconf =
    { pkgs, ... }:
    {
      system = import ./system.nix { inherit pkgs me; };
    };
in
[
  darwinconf
  { security.pam.services.sudo_local.touchIdAuth = true; }
  mac-app-util.darwinModules.default
  home-manager.darwinModules.home-manager
  (import ../../home/homemanager {
    inherit me sops-nix;
    extraImports = [ mac-app-util.homeManagerModules.default ];
  })
  (import ../nix { inherit host-system nix-vscode-extensions nuenv; })
  ../fonts
  ../locale
  ../services
  ./homebrew
  (import ../users { inherit me; })
]
