{ pkgs, ... }:

{
  enable = true;
  onActivation.cleanup = "uninstall";
  brews = [
    "coreutils"
  ];
  casks = [
    "alfred"
    "bartender"
    # "drivethrurpg"
    # "font-fira-code"
    # "obsidian"
    # "spotify"
    # "zotero"
  ];
}