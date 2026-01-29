{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;

    # Re-enable when Nix versioning issue is sorted
    nix-direnv.enable = true;
  };
}
