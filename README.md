# macOS Nix Configuration with Home Manager

A declarative macOS system configuration using Nix with nix-darwin and Home Manager. This setup provides reproducible system and user-level configurations for macOS.

## What is This?

This repository contains a complete Nix flake configuration that manages:

- **System-level settings**: macOS system preferences, keyboard mappings, dock settings
- **Package management**: Development tools, terminal utilities, and applications
- **User environment**: Shell configuration (Zsh and Fish), git settings, SSH config
- **Homebrew integration**: GUI applications and tools not available in nixpkgs
- **Secrets management**: Encrypted secrets using sops-nix with age encryption
- **Modular configuration**: Each program configured in its own module for maintainability

## Prerequisites

- macOS (this configuration is set up for Apple Silicon - `aarch64-darwin`)
- Administrator access on your Mac
- Basic familiarity with the command line

## Installation

### 1. Install Determinate Nix Installer

The Determinate Nix Installer is a fast, modern installer that sets up Nix with flakes enabled by default:

```bash
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

This installer:
- Enables flakes and nix-command experimental features automatically
- Configures the Nix daemon properly for macOS
- Sets up the Determinate Nix binary cache for faster downloads

### 2. Clone This Repository

```bash
git clone <your-repo-url> ~/.config/nix
cd ~/.config/nix
```

### 3. Customize Your Configuration

Before building, customize the configuration for your system:

#### Create your user configuration

Edit [me.nix](me.nix) with your information:

```nix
{ ... }: {
  email = "your.email@example.com";
  full-name = "Your Full Name";
  user-name = "yourusername";
}
```

#### Set up secrets (required for SSH and pet)

This repo uses **sops-nix** with **age encryption** to manage secrets. See [SOPS_SETUP_INSTRUCTIONS.md](SOPS_SETUP_INSTRUCTIONS.md) for detailed setup.

Quick setup:
1. Generate an age key:
   ```bash
   mkdir -p ~/.config/sops/age
   age-keygen -o ~/.config/sops/age/keys
   ```
2. Add your public key to [.sops.yaml](.sops.yaml)
3. Create encrypted secrets file:
   ```bash
   sops secrets/secrets.yaml
   ```

The secrets file should contain:
```yaml
ssh_private_key: |
  -----BEGIN OPENSSH PRIVATE KEY-----
  your-private-key-here
  -----END OPENSSH PRIVATE KEY-----
github_gist_token: ghp_your_token_here
```

#### Verify your user ID

Check your user ID matches the configuration:

```bash
id -u
```

Update [user.nix](user.nix) if your UID is different from 501.

### 4. Build and Apply Configuration

First build (this will take a while as it downloads and builds packages):

```bash
nix build .#darwinConfigurations.macbook.system --extra-experimental-features "nix-command flakes"
```

Apply the configuration:

```bash
./result/sw/bin/darwin-rebuild switch --flake ~/.config/nix#macbook
```

### 5. Restart Your Shell

After the first build, restart your terminal or run:

```bash
exec zsh
```

## Repository Structure

```
.
├── flake.nix              # Main flake configuration and system modules
├── flake.lock             # Locked dependency versions
├── .sops.yaml             # SOPS configuration for secrets management
├── me.nix                 # User information (email, name, username)
├── user.nix               # User account configuration
├── macos.nix              # macOS system preferences and settings
├── secrets/
│   ├── id_ed25519.pub     # SSH public key (not encrypted)
│   └── secrets.yaml       # Encrypted secrets (SSH key, tokens)
└── home/
    ├── packages.nix       # User packages installed via Nix
    ├── programs/          # Modular program configurations
    │   ├── default.nix    # Imports all program modules
    │   ├── autojump/
    │   ├── fish/
    │   ├── fzf/
    │   ├── git/
    │   ├── pet/           # Snippet manager with GitHub Gist sync
    │   ├── ssh/
    │   ├── vscode/
    │   └── zsh/
    ├── shell-aliases.nix  # Shared shell aliases across zsh/fish
    ├── sops.nix           # SOPS/secrets configuration
    └── homebrew.nix       # Homebrew packages, casks, and taps
```

### Key Files Explained

- **[flake.nix](flake.nix)**: Entry point that orchestrates all configurations and defines the system build
- **[.sops.yaml](.sops.yaml)**: SOPS configuration defining encryption keys and rules
- **[macos.nix](macos.nix)**: System-wide macOS settings (dock, finder, keyboard, trackpad, etc.)
- **[home/packages.nix](home/packages.nix)**: CLI tools and applications installed via Nix
- **[home/programs/](home/programs/)**: Modular program configurations, each in its own directory
- **[home/shell-aliases.nix](home/shell-aliases.nix)**: Shared shell aliases used by zsh and fish
- **[home/sops.nix](home/sops.nix)**: Secrets decryption configuration
- **[home/homebrew.nix](home/homebrew.nix)**: GUI applications and tools installed via Homebrew

## Making Changes

### Adding Packages

**Nix packages** (in [home/packages.nix](home/packages.nix)):
```nix
dev = with pkgs; [ git-crypt lazygit podman your-new-package ];
```

**Homebrew casks** (in [homebrew.nix](homebrew.nix)):
```nix
casks = [
  "alfred"
  "your-new-app"
];
```

Search for packages:
```bash
# Search Nix packages
nix search nixpkgs package-name

# Search Homebrew casks
brew search package-name
```

### Modifying System Settings

Edit [macos.nix](macos.nix) to change system preferences. See the [nix-darwin options documentation](https://daiderd.com/nix-darwin/manual/index.html#sec-options) for all available options.

### Updating Program Configurations

Each program has its own module in [home/programs/](home/programs/). For example:
- **Git**: Edit [home/programs/git/default.nix](home/programs/git/default.nix)
- **Zsh**: Edit [home/programs/zsh/default.nix](home/programs/zsh/default.nix)
- **VSCode**: Edit [home/programs/vscode/default.nix](home/programs/vscode/default.nix)

Shared shell aliases are in [home/shell-aliases.nix](home/shell-aliases.nix).

See the [Home Manager options search](https://mipmip.github.io/home-manager-option-search/) for available options.

### Applying Changes

After making any changes, use the convenient `nxs` alias:

```bash
nxs
```

This runs `sudo darwin-rebuild switch --flake ~/.config/nix`.

Or run the full command:

```bash
darwin-rebuild switch --flake ~/.config/nix#macbook
```

## Updating Dependencies

Update all flake inputs to their latest versions:

```bash
nix flake update
```

Update a specific input:

```bash
nix flake update nixpkgs
```

Then rebuild:

```bash
darwin-rebuild switch --flake ~/.config/nix#macbook
```

## Useful Commands

```bash
# Rebuild and switch (using alias)
nxs

# Or the full command
darwin-rebuild switch --flake ~/.config/nix#macbook

# Build without switching (test before applying)
darwin-rebuild build --flake ~/.config/nix#macbook

# Format all Nix files
treefmt

# Edit encrypted secrets
sops secrets/secrets.yaml

# Check what will change without building
nix flake check

# Show the current system configuration
darwin-rebuild --flake ~/.config/nix#macbook --show-trace

# Garbage collect old generations
nix-collect-garbage -d

# List system generations
ls -lh /nix/var/nix/profiles/system-*-link
```

## Features

### Included Tools

**Development**: age, sops, lazygit
**Terminal**: btop, fd, just, ripgrep, tldr, autojump, fzf, pet (snippet manager)
**Nix**: nixfmt, nixfmt-tree (treefmt), nix-direnv, direnv
**Applications**: Discord, Obsidian, VSCode with Claude Code and Nix IDE extensions

### Shell Configuration

- **Zsh** (default shell) with custom aliases and environment setup
- **Fish shell** also configured and available
- **Autojump** for quick directory navigation
- **fzf** for fuzzy finding
- **direnv** for project-specific environments
- **pyenv** for Python version management

### Git Configuration

Pre-configured with ([home/programs/git/](home/programs/git/)):
- Useful aliases (ba, co, cob, cm, cam, s, l, pr, whoops, etc.)
- Difftastic for better diffs
- Git LFS support
- Sensible global gitignore
- Auto-setup remote branches on push

### Secrets Management

Uses **sops-nix** with **age encryption**:
- SSH private keys automatically decrypted to `~/.ssh/id_ed25519`
- GitHub Gist token for pet snippet sync via environment variable
- Secrets stored encrypted in git at [secrets/secrets.yaml](secrets/secrets.yaml)
- Private age key at `~/.config/sops/age/keys` (never committed)
- Configuration in [.sops.yaml](.sops.yaml) and [home/sops.nix](home/sops.nix)

### macOS Preferences

Automatically configured:
- Dark mode enabled
- Dock on left side, auto-hide
- Fast key repeat rate
- Touch ID for sudo
- Screenshots saved to clipboard
- Caps Lock remapped to Control
- Finder shows all files and extensions

## Troubleshooting

### "error: experimental features not enabled"

If you installed with Determinate Nix, this shouldn't happen. Otherwise, add to commands:
```bash
--extra-experimental-features "nix-command flakes"
```

### Build Failures

Check the build output for specific errors. Common issues:
- Unfree packages: Update `allowUnfreePredicate` in [flake.nix:28-32](flake.nix#L28-L32)
- Network issues: Check your internet connection and try again
- Disk space: Nix needs significant space, run `nix-collect-garbage -d`

### Homebrew Issues

If Homebrew commands fail:
```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Shell Not Changing

After configuration changes, you may need to:
```bash
exec zsh
```

Or fully restart your terminal. You can also switch to fish by running `exec fish`.

## Learning Resources

- [Nix Official Manual](https://nixos.org/manual/nix/stable/)
- [nix-darwin Documentation](https://github.com/LnL7/nix-darwin)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Determinate Systems Docs](https://docs.determinate.systems/)
- [Nix Package Search](https://search.nixos.org/packages)

## Architecture Decisions

### Modular Program Configuration

Each program lives in its own module under [home/programs/](home/programs/):
- **Maintainability**: Easier to find and update specific program configs
- **Reusability**: Modules can be easily shared or copied to other setups
- **Clarity**: Each module has a focused purpose
- **Scalability**: Adding new programs doesn't clutter existing files

### SOPS-nix for Secrets

Switched from git-crypt to sops-nix because:
- **Better integration**: Native Nix support with proper activation-time decryption
- **Multiple recipients**: Can easily add team members' keys
- **Granular encryption**: Can encrypt specific fields in YAML, not just whole files
- **Age encryption**: Modern, simple encryption with smaller keys than GPG

### Shared Shell Aliases

[home/shell-aliases.nix](home/shell-aliases.nix) provides:
- **DRY principle**: Define aliases once, use in multiple shells
- **Consistency**: Same aliases work in zsh and fish
- **Extensibility**: Easy to add shell-specific aliases when needed

## Philosophy

This configuration follows these principles:

1. **Declarative**: Everything is defined in code
2. **Reproducible**: Same configuration produces same result
3. **Modular**: Organized into logical, single-purpose modules
4. **Documented**: Comments explain non-obvious choices
5. **Practical**: Balances purity with pragmatism (e.g., Homebrew for GUI apps)
6. **Secure**: Secrets properly encrypted and managed with sops-nix

## Contributing

When making changes:
1. Format code with `treefmt` before committing
2. Test locally with `darwin-rebuild build` first
3. Keep user-specific info in [me.nix](me.nix)
4. Keep secrets in [secrets/secrets.yaml](secrets/secrets.yaml) (encrypted)
5. New programs should go in their own module under [home/programs/](home/programs/)
6. Commit with descriptive messages using the conventional commits format
7. Document significant changes in this README

## License

This configuration is provided as-is for personal use. Adapt it to your needs.
