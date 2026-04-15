{ ... }:
let
  shellAliases = import ../shell/aliases.nix { };
in
{
  programs.zsh = {
    enable = true;
    shellAliases = shellAliases.common // shellAliases.zsh;
    history = {
      size = 50000;
      save = 50000;
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
      share = true;
    };
    initContent = ''
      export PATH="/opt/homebrew/bin:$PATH"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
