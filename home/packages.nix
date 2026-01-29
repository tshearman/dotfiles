{ pkgs, ... }:
let
  apps = with pkgs; [
    obsidian
  ];
  dev = with pkgs; [
    age
    lazygit
    sops
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
    imagemagick
    ghostscript
    texliveFull
  ];

in
apps ++ dev ++ nixTools ++ term ++ others
