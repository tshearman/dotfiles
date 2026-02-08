{ ... }:
let
  nixAliases = {
    nxs = "sudo darwin-rebuild switch --flake ~/.config/nix";
    nxc = "sudo darwin-rebuild check --flake ~/.config/nix";
    nxu = "nix flake update";
  };

  gitAliases = {
    g = "git";
    lgit = "lazygit";
  };

  navigationAliases = {
    ll = "ls -lah --color=auto";
    ".." = "cd ..";
    "..." = "cd ../..";
  };
in
{
  common = nixAliases // gitAliases // navigationAliases // { };
  zsh = { };
  fish = { };
}
