{ pkgs, config, ... }:
{
  imports = [
    ./zoxide
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
