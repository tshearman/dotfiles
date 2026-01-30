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
    ./tmux
    ./vscode
    ./zsh
  ];
}
