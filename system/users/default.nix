{ me }:
{ pkgs, ... }:
{
  users.knownUsers = [ me.user-name ];
  users.users."${me.user-name}" = import ./user.nix { inherit pkgs me; };
}
