{
  host-system,
  nix-vscode-extensions,
  ...
}:
{ lib, ... }:
{
  nix.enable = true;
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
      "vscode-extension-ms-vscode-remote-remote-ssh"
      "vscode-extension-ms-vscode-remote-remote-ssh-edit"
      "vscode-extension-ms-vscode-remote-explorer"
      "vscode"
    ];
  nixpkgs.hostPlatform = host-system;
  nixpkgs.overlays = [
    nix-vscode-extensions.overlays.default
  ];
}
