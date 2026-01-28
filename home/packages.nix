{ pkgs, ... }:
let
  apps = with pkgs; [ discord obsidian ];
  dev = with pkgs; [ git-crypt lazygit podman podman-compose uv gcc-arm-embedded ];
  nixTools = with pkgs; [ nixfmt-classic nixpkgs-fmt nix-direnv ];
  term = with pkgs; [ btop coreutils fd just ripgrep tldr ];
  others = with pkgs; [ avrdude dfu-programmer dfu-util imagemagick ghostscript texliveFull poppler-utils pcre2 ];

in apps ++ dev ++ nixTools ++ term ++ others
