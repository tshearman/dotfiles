{ pkgs, me, ... }:
{
  home = "/Users/${me.user-name}";
  name = me.user-name;
  shell = pkgs.zsh;
  uid = 501;
}
