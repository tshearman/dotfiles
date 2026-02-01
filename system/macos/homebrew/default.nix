{ pkgs, ... }:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [
    ];
    brews = [
    ];
    casks = [
      "1password"
      "1password-cli"
      # "alfred"
      # "balenaetcher"
      # "bartender"
      # "drivethrurpg"
      "discord"
      # "makemkv"
      # "qmk-toolbox"
      "mullvad-browser"
      "mullvad-vpn"
      "spotify"
    ];
    masApps = {
      "1Password for Safari" = 1569813296;
    };
  };
}
