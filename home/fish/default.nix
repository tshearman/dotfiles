{ ... }:
let
  shellAliases = import ../shell-aliases.nix { };
in
{
  programs.fish = {
    enable = true;
    shellAliases = shellAliases.common // shellAliases.fish;
    shellInit = ''
      fish_add_path "/opt/homebrew/bin"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
