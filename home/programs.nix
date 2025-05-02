{ pkgs, user, secrets, ... }: {
  autojump = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  fish = {
    enable = true;
    shellAliases = { lgit = "lazygit"; };
  };

  fzf = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  git = {
    enable = true;
    difftastic.enable = true;
    aliases = {
      ba = "branch -a";
      bd = "branch -D";
      br = "branch";
      c = "commit";
      cam = "commit -am";
      cm = "commit -m";
      co = "checkout";
      cob = "checkout -b";
      cp = "commit -p";
      d = "diff";
      fix = "rebase --exec 'git commit --amend --no-edit -S' -i origin/develop";
      l =
        "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";
      pr = "pull --rebase";
      s = "status";
      st = "status";
      whoops = "reset --hard";
      wipe = "commit -s";
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
    extraConfig = {
      core = {
        editor = "nvim";
        whitespace = "trailing-space,space-before-tab";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
    lfs = { enable = true; };
    package = pkgs.gitAndTools.gitFull;
    userEmail = user.email;
    userName = user.full-name;
  };

  home-manager = { enable = true; };

  kitty = {
    enable = true;
    font = {
      name = "FiraCodeNerdFontMono";
      size = 14;
    };
  };

  pet = {
    enable = true;
    settings = {
      Gist.access_token = secrets.git-gist-key;
      Gist.auto_sync = true;
    };
  };

  ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      IgnoreUnknown UseKeychain
      AddKeysToAgent yes
      UseKeychain yes
      IdentityFile ~/.ssh/id_ed25519
    '';
  };

  vscode = {
    enable = true;
    profiles.default = {
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = true;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        davidanson.vscode-markdownlint
        eamodio.gitlens
        esbenp.prettier-vscode
        mechatroner.rainbow-csv
        mhutchie.git-graph
        brettm12345.nixfmt-vscode
        jnoortheen.nix-ide
      ];
      userSettings = {
        # This property will be used to generate settings.json:
        # https://code.visualstudio.com/docs/getstarted/settings#_settingsjson
        "editor.formatOnSave" = true;
        "terminal.integrated.shell.osx" = "fish";
      };
      keybindings = [
        # See https://code.visualstudio.com/docs/getstarted/keybindings#_advanced-customization
        {
          key = "shift+cmd+j";
          command = "terminal.focus";
        }
      ];
    };
  };
}
