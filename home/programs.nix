{ pkgs, config, ... }:
let
  user = import ../me.nix { };
in
{
  # Import individual program modules
  imports = [
    ./autojump
    ./fish
    ./fzf
    ./git
    ./pet
    ./ssh
    ./vscode
    ./zsh
  ];

  home.sessionVariables = {
    SOPS_AGE_KEY_FILE = config.sops.age.keyFile;
  };

  programs = {

  };
}
