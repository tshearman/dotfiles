{ pkgs, ... }:
{
  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.inconsolata
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.iosevka
  ];
}
