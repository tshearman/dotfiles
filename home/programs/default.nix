{ pkgs, config, ... }:
{
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
