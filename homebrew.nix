{ pkgs, ... }:

{
  enable = true;
  onActivation.cleanup = "uninstall";
  brews = [ "coreutils" ];
  casks = [
    "alfred"
    "bartender"
    "drivethrurpg"
    "spotify"
    # "font-fira-code"
    # "obsidian"
    # "zotero"
  ];
}
