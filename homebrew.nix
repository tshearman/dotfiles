{ pkgs, ... }:

{
  enable = true;
  onActivation.cleanup = "uninstall";
  casks = [ "alfred" "bartender" "drivethrurpg" "spotify" ];
}
