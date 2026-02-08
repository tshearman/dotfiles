{ pkgs, ... }:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [ ];
    brews = [ ];
    casks = [
      "1password-cli"
      "1password"
      "autodesk-fusion"
      "discord"
      "mullvad-browser"
      "mullvad-vpn"
      "spotify"
      # "alfred"
      # "balenaetcher"
      # "bartender"
      # "drivethrurpg"
      # "makemkv"
      # "qmk-toolbox"
    ];
    masApps = {
      "1Password for Safari" = 1569813296;
    };
  };
}
