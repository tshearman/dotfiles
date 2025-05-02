{ pkgs, ... }:
let
  apps = with pkgs; [ discord obsidian ];
  dev = with pkgs; [ git-crypt lazygit podman podman-compose ];
  nixTools = with pkgs; [ nixfmt-classic nixpkgs-fmt ];
  term = with pkgs; [ btop coreutils fd just psutils ripgrep tldr ];

in apps ++ dev ++ nixTools ++ term
