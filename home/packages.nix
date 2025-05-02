{ pkgs, ... }:
let
  apps = with pkgs; [ discord obsidian ];
  dev = with pkgs; [ git git-crypt lazygit podman podman-compose ];
  nixTools = with pkgs; [ nixfmt nixpkgs-fmt ];
  term = with pkgs; [ coreutils fd just btop tldr ripgrep psutils ];

in term ++ dev ++ nixTools ++ apps

