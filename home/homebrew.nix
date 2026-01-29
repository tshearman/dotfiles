{ pkgs, ... }:

{
  enable = true;
  onActivation.cleanup = "uninstall";
  taps = [
  ];
  brews = [
    # "pyenv-virtualenv"
    # "pyenv"
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
    "spotify"
  ];
}
