{ pkgs, ... }:

{
  enable = true;
  onActivation.cleanup = "uninstall";
  taps = [ 
    # "osx-cross/avr" 
    # "FLEWID-AB/homebrew-pdfjam" 
  ];
  brews = [ 
    # "pyenv-virtualenv"
    # "pyenv"
    # "direnv"
  ];
  casks = [
    # "alfred"
    # "balenaetcher"
    # "bartender"
    # "drivethrurpg"
    # "makemkv"
    # "qmk-toolbox"
    # "spotify"
  ];
}
