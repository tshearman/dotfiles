{ ... }:
{
  # SSH public key
  home.file.".ssh/id_ed25519.pub".source = ../../secrets/id_ed25519.pub;

  programs.ssh = {
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
}
