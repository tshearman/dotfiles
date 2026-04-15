{ ... }:
let
  nixAliases = {
    nxs = "sudo darwin-rebuild switch --flake ~/.config/nix";
    nxc = "sudo darwin-rebuild check --flake ~/.config/nix";
    nxu = "nix flake update";
  };

  gitAliases = {
    # g = "git";
    lgit = "lazygit";
  };

  navigationAliases = {
    ll = "eza -lah --icons --git";
    ls = "eza --icons";
    tree = "eza --tree --icons";
    ".." = "cd ..";
    "..." = "cd ../..";
  };

  toolAliases = {
    cat = "bat";
    grep = "rg";
    man = "batman";
    "?" = "tldr";
    y = "pbcopy";
  };
in
{
  common = nixAliases // gitAliases // navigationAliases // toolAliases;
  zsh = { };
  fish = { };
}
