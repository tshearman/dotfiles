{ pkgs, config, ... }:
{
  imports = [
    ./autojump
    ./direnv
    ./fish
    ./fzf
    ./git
    ./pet
    ./shell
    ./ssh
    ./starship
    ./vscode
    ./zsh
  ];
}
