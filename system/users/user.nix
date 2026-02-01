{ pkgs, me, ... }:
{
  home = if pkgs.stdenv.isDarwin then "/Users/${me.user-name}" else "/home/${me.user-name}";
  name = me.user-name;
  shell = pkgs.zsh;
  uid = 501;
}
