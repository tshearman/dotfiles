{
  pkgs,
  user,
  config,
  ...
}:
{
  autojump = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  fish = {
    enable = true;
    shellAliases = {
      lgit = "lazygit";
    };
    shellInit = ''
      fish_add_path "/opt/homebrew/bin"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };

  zsh = {
    enable = true;
    shellAliases = {
      lgit = "lazygit";
      nxs = "sudo darwin-rebuild switch --flake ~/.config/nix";
    };
    initContent = ''
      export PATH="/opt/homebrew/bin:$PATH"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };

  fzf = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

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

  home-manager = {
    enable = true;
  };

  pet = {
    enable = true;
    settings = {
      # Note: Gist.access_token is managed by sops-nix
      # The token is deployed to ~/.config/pet/.github_token
      # You may need to configure pet to read from this file or set it manually
      Gist.auto_sync = true;
    };
  };

  ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      extraOptions = {
        IgnoreUnknown = "UseKeychain";
        AddKeysToAgent = "yes";
        UseKeychain = "yes";
        IdentityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  # https://davi.sh/blog/2024/11/nix-vscode/
  vscode = {
    enable = true;
    profiles.default = {
      userSettings = {
        # https://code.visualstudio.com/docs/getstarted/settings#_settingsjson
        "editor.formatOnSave" = true;
        "chat.commandCenter.enabled" = false;
        "claudeCode.preferredLocation" = "panel";
        "claudeCode.useCtrlEnterToSend" = true;
      };
      keybindings = [
        # https://code.visualstudio.com/docs/getstarted/keybindings#_advanced-customization
        {
          key = "shift+cmd+j";
          command = "workbench.action.focusActiveEditorGroup";
          when = "terminalFocus";
        }
      ];
      extensions = [
        pkgs.vscode-marketplace.jnoortheen.nix-ide
        pkgs.vscode-marketplace.anthropic.claude-code
      ];
    };
  };
}
