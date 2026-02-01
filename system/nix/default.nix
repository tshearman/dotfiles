{
  host-system,
  nix-vscode-extensions,
  nuenv,
  ...
}:
{ lib, ... }:
{
  nix.enable = false;
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.trusted-users = [
    "root"
    "toby"
  ];
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "claude-code"
      "discord"
      "obsidian"
      "unrar"
      "vscode-extension-anthropic-claude-code"
      "vscode"
    ];
  nixpkgs.hostPlatform = host-system;
  nixpkgs.overlays = [ 
    nix-vscode-extensions.overlays.default 
    nuenv.overlays.default
  ];
}
