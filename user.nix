{ pkgs, user, ... }: {
  name = user.user-name;
  home = "/Users/${user.user-name}";
  uid = 501;
  shell = pkgs.fish;
}
