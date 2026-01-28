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
    shellInit = ''
    export QMK_HOME='~/qmk_firmware'
    fish_add_path "/opt/homebrew/bin"
    eval "$(/opt/homebrew/bin/brew shellenv)"

    pyenv init - | source
    pyenv virtualenv-init - | source

    direnv hook fish | source
  '';
  };

  zsh = {
    enable = true;
    shellAliases = { lgit = "lazygit"; };
    initExtra = ''
    export QMK_HOME='~/qmk_firmware'
    export PATH="/opt/homebrew/bin:$PATH"
    eval "$(/opt/homebrew/bin/brew shellenv)"

    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

    eval "$(direnv hook zsh)"
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
    
    settings.core = {
      editor = "nvim";
      whitespace = "trailing-space,space-before-tab";
    };
    settings.init.defaultBranch = "main";
    settings.push.autoSetupRemote = true;
    lfs = { enable = true; };
    settings.user.email = user.email;
    settings.user.name = user.full-name;
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
    extraConfig = ''
      IgnoreUnknown UseKeychain
      AddKeysToAgent yes
      UseKeychain yes
      IdentityFile ~/.ssh/id_ed25519
    '';
  };
}
