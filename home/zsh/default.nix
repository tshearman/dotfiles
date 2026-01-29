{ ... }:
let
  shellAliases = import ../shell-aliases.nix { };
in
{
  programs.zsh = {
    enable = true;
    shellAliases = shellAliases.common // shellAliases.zsh;
    initContent = ''
      export PATH="/opt/homebrew/bin:$PATH"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
