{ pkgs, config, ... }:
let
  user = import ../../me.nix { };
in
{
  # Import individual program modules
  imports = [
    ./autojump
    ./fish
    ./fzf
    ./git
    ./pet
    ./shell
    ./ssh
    ./vscode
    ./zsh
  ];
}
