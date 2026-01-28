{ pkgs, ... }:
let
  apps = with pkgs; [ discord obsidian ];
  dev = with pkgs; [ git-crypt lazygit gcc-arm-embedded ];
  nixTools = with pkgs; [ nixfmt nix-direnv ];
  term = with pkgs; [ btop coreutils fd just ripgrep tldr ];
  others = with pkgs; [ imagemagick ghostscript texliveFull ];

in apps ++ dev ++ nixTools ++ term ++ others
