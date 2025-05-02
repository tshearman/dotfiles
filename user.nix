{ pkgs, user, ... }: {
  home = "/Users/${user.user-name}";
  name = user.user-name;
  shell = pkgs.fish;
  uid = 501;
}
