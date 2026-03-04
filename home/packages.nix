{ pkgs, ... }:
let
  apps = with pkgs; [
    obsidian
  ];
  dev = with pkgs; [
    age
    lazygit
    sops
    unrar
  ];
  nixTools = with pkgs; [
    nixfmt
    nixfmt-tree
    nix-direnv
    direnv
  ];
  term = with pkgs; [
    btop
    coreutils
    fd
    just
    ripgrep
    tldr
  ];
  others = with pkgs; [
    ghostscript
    imagemagick
    inkscape
    texliveFull
  ];

in
apps ++ dev ++ nixTools ++ term ++ others
