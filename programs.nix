{ pkgs, ... }: {
  fish = {
    enable = true;
    shellAliases = { };
  };
  kitty = { enable = true; };
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
  autojump = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
  home-manager.enable = true;
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
