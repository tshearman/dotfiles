{ ... }:
{
  # https://davi.sh/blog/2024/11/nix-vscode/
  programs.vscode = {
    enable = true;
    profiles.default = {
      userSettings = {
        # https://code.visualstudio.com/docs/getstarted/settings#_settingsjson
        "chat.commandCenter.enabled" = false;
        "claudeCode.preferredLocation" = "panel";
        "claudeCode.useCtrlEnterToSend" = true;
        "editor.formatOnSave" = true;
        "terminal.integrated.enableMultiLinePasteWarning" = "never";
        "explorer.confirmDelete" = false;
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
