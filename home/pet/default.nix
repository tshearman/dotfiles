{
  pkgs,
  config,
  lib,
  ...
}:
let
  tokenPath = config.sops.secrets.github_gist_token.path;
in
{
  programs.pet = {
    enable = true;
    settings = {
      Gist = {
        auto_sync = true;
        gist_id = "";
      };
    };
  };

  # Set PET_GITHUB_ACCESS_TOKEN environment variable from sops secret
  programs.zsh.initContent = lib.mkAfter ''
    export PET_GITHUB_ACCESS_TOKEN="$(cat ${tokenPath} 2>/dev/null || echo "")"
  '';

  programs.fish.shellInit = lib.mkAfter ''
    if test -f ${tokenPath}
      set -gx PET_GITHUB_ACCESS_TOKEN (cat ${tokenPath})
    end
  '';
}
