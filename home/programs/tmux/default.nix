{
  programs.tmux = {
    enable = true;
    clock24 = true;
    escapeTime = 0;
    baseIndex = 1;
    shortcut = "b";
    extraConfig = (builtins.readFile ./tmux.conf);
  };
}
