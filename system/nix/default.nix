{
  host-system,
  nix-vscode-extensions,
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
      "discord"
      "obsidian"
      "vscode"
      "vscode-extension-anthropic-claude-code"
      "claude-code"
    ];
  nixpkgs.hostPlatform = host-system;
  nixpkgs.overlays = [ nix-vscode-extensions.overlays.default ];
}
