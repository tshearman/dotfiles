{
  me,
  sops-nix,
  extraImports ? [ ],
}:
{ pkgs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bkup";
  home-manager.users."${me.user-name}" = {
    home.packages = import ../packages.nix { inherit pkgs; };
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;
    imports = [
      sops-nix.homeManagerModules.sops
      ../sops.nix
      ../programs
    ] ++ extraImports;
  };
}
