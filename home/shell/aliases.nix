{ ... }:
{
  # Common shell aliases shared across all shells (zsh, fish, bash, etc.)
  common = {
    lgit = "lazygit";
    nxs = "sudo darwin-rebuild switch --flake ~/.config/nix";
  };

  # Zsh-specific aliases (or aliases that only make sense in zsh context)
  zsh = { };

  # Fish-specific aliases (currently none, but structure is here if needed)
  fish = { };
}
