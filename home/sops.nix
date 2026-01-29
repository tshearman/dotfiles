{ config, lib, ... }:
{
  sops = {
    # Path to the age key file used for decryption
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    # Default sops file location
    defaultSopsFile = ../secrets/secrets.yaml;

    # Secrets to decrypt and where to place them
    secrets = {
      # SSH private key
      ssh_private_key = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519";
        mode = "0600";
      };

      # GitHub Gist API token (for pet or other tools)
      github_gist_token = {
        path = "${config.home.homeDirectory}/.secrets/github_gist_token";
        mode = "0600";
      };
    };
  };

  # Fix for macOS launchd PATH issue
  # The sops-nix launchd agent needs PATH set to find system utilities
  launchd.agents.sops-nix.config.EnvironmentVariables.PATH =
    lib.mkForce "/usr/bin:/bin:/usr/sbin:/sbin:/run/current-system/sw/bin";
}
