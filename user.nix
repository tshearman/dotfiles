{ pkgs, user, ... }: {
  name = user.name;
  home = "/Users/${user.name}";
  packages = with pkgs; [
    btop
    discord
    fd
    git
    just
    kitty
    lazygit
    nixfmt
    obsidian
    podman
    podman-compose
    psutils
    ripgrep
    tldr
  ];
  uid = 501;
  shell = pkgs.fish;
}
