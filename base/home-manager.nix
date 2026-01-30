{
  user,
  mac-app-util,
  sops-nix,
}:
{ pkgs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bkup";
  home-manager.users."${user.user-name}" = {
    home.packages = import ../home/packages.nix { inherit pkgs; };
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;
    imports = [
      mac-app-util.homeManagerModules.default
      sops-nix.homeManagerModules.sops
      ../home/sops.nix
      ../home/programs
    ];
  };
}
