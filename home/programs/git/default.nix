{ ... }:
let
  user = import ../../../system/users/me.nix { };
in
{
  programs = {

    difftastic = {
      git.enable = true;
    };

    git = {
      enable = true;
      settings.alias = {
        ba = "branch -a";
        bD = "branch -D";
        b = "branch";
        br = "branch";
        c = "commit";
        cam = "commit -am";
        cm = "commit -m";
        co = "checkout";
        cob = "checkout -b";
        cp = "commit -p";
        d = "diff";
        fix = "rebase --exec 'git commit --amend --no-edit -S' -i origin/develop";
        l = "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";
        pr = "pull --rebase";
        s = "status";
        st = "status";
        whoops = "reset --hard";
        wipe = "commit -s";
        au = "add . -u";
        amend = "commit --amend --no-edit";
      };
      ignores = [
        ".cache/"
        ".DS_Store"
        ".direnv/"
        ".idea/"
        "*.swp"
        "built-in-stubs.jar"
        ".elixir_ls/"
        ".vscode/"
        "npm-debug.log"
      ];

      settings.core = {
        editor = "nvim";
        whitespace = "trailing-space,space-before-tab";
      };
      settings.init.defaultBranch = "main";
      settings.push.autoSetupRemote = true;
      lfs = {
        enable = true;
      };
      settings.user.email = user.email;
      settings.user.name = user.full-name;
    };
  };
}
