{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tailscale
    devenv
  ];

  services.tailscale.enable = true;
}
