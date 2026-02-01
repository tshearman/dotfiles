{ pkgs, ... }:

let
  colorTheme = "Atom One Dark";
  font = "Iosevka Extended, FiraCode Nerd Font Mono, monospace";
  terminalFont = "Iosevka Extended, FiraCode Nerd Font Mono";
  iconTheme = "material-icon-theme";
in

{
  # https://davi.sh/blog/2024/11/nix-vscode/
  programs.vscode = {
    enable = true;
    profiles.default = {
      userSettings = {
        "[nix]" = {
          "editor.defaultFormatter" = "/etc/profiles/per-user/toby/bin/nixfmt";
          "editor.formatOnSave" = true;
        };
        "chat.commandCenter.enabled" = false;
        "claudeCode.preferredLocation" = "panel";
        "claudeCode.useCtrlEnterToSend" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.fontFamily" = font;
        "editor.fontLigatures" = true;
        "editor.fontSize" = 12;
        "editor.formatOnSave" = true;
        "editor.wordWrap" = "wordWrapColumn";
        "editor.wordWrapColumn" = 120;
        "explorer.confirmDelete" = false;
        "rust-analyzer.server.path" = "rust-analyzer";
        "search.exclude" = {
          "**/.direnv" = true;
          "**/.git" = true;
          "**/node_modules" = true;
          "*.lock" = true;
          "dist" = true;
          "tmp" = true;
        };
        "terminal.integrated.enableMultiLinePasteWarning" = "never";
        "terminal.integrated.fontFamily" = terminalFont;
        "workbench.colorTheme" = colorTheme;
        "workbench.iconTheme" = iconTheme;
        "terminal.integrated.stickyScroll.enabled" = false;
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
