# macOS Nix Configuration with Home Manager

A declarative macOS system configuration using Nix with nix-darwin and Home Manager. This setup provides reproducible system and user-level configurations for macOS.

## What is This?

This repository contains a complete Nix flake configuration that manages:

- **System-level settings**: macOS system preferences, keyboard mappings, dock settings
- **Package management**: Development tools, terminal utilities, and applications
- **User environment**: Shell configuration (Zsh and Fish), git settings, SSH config
- **Homebrew integration**: GUI applications and tools not available in nixpkgs
- **Secrets management**: Encrypted secrets using git-crypt

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

#### Set up secrets (optional)

This repo uses git-crypt to encrypt [secrets.nix](secrets.nix). For your first setup:

1. Install git-crypt: `brew install git-crypt` or it will be installed via Nix
2. Either:
   - Initialize your own secrets: `git-crypt init`
   - Or create a plain [secrets.nix](secrets.nix) file:
     ```nix
     { ... }: {
       git-gist-key = "your-github-gist-token";
     }
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
├── me.nix                 # User information (email, name, username)
├── user.nix               # User account configuration
├── secrets.nix            # Encrypted secrets (git-crypt)
├── macos.nix              # macOS system preferences and settings
├── homebrew.nix           # Homebrew packages, casks, and taps
└── home/
    ├── packages.nix       # User packages installed via Nix
    ├── programs.nix       # Program configurations (git, zsh, fish, etc.)
    ├── scripts.fish       # Custom Fish shell scripts
    └── scripts.zsh        # Custom Zsh shell scripts
```

### Key Files Explained

- **[flake.nix](flake.nix)**: Entry point that orchestrates all configurations and defines the system build
- **[macos.nix](macos.nix)**: System-wide macOS settings (dock, finder, keyboard, trackpad, etc.)
- **[homebrew.nix](homebrew.nix)**: GUI applications and tools installed via Homebrew
- **[home/packages.nix](home/packages.nix)**: CLI tools and applications installed via Nix
- **[home/programs.nix](home/programs.nix)**: Configuration for programs like git, zsh, fish, kitty, ssh

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

Edit [home/programs.nix](home/programs.nix) to configure programs. See the [Home Manager options search](https://mipmip.github.io/home-manager-option-search/) for available options.

### Applying Changes

After making any changes:

```bash
darwin-rebuild switch --flake ~/.config/nix#macbook
```

Or use the shorthand (after first install):

```bash
darwin-rebuild switch --flake ~/.config/nix
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
# Rebuild and switch to new configuration
darwin-rebuild switch --flake ~/.config/nix#macbook

# Build without switching (test before applying)
darwin-rebuild build --flake ~/.config/nix#macbook

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

**Development**: git-crypt, lazygit, podman, uv, gcc-arm-embedded
**Terminal**: btop, fd, just, ripgrep, tldr, autojump, fzf
**Nix**: nixfmt, nix-direnv
**Applications**: Discord, Obsidian, Kitty terminal

### Shell Configuration

- **Zsh** (default shell) with custom aliases and environment setup
- **Fish shell** also configured and available
- **Autojump** for quick directory navigation
- **fzf** for fuzzy finding
- **direnv** for project-specific environments
- **pyenv** for Python version management

### Git Configuration

Pre-configured with:
- Useful aliases ([programs.nix:37-56](home/programs.nix#L37-L56))
- Difftastic for better diffs
- Git LFS support
- Sensible global gitignore

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

## Philosophy

This configuration follows these principles:

1. **Declarative**: Everything is defined in code
2. **Reproducible**: Same configuration produces same result
3. **Modular**: Organized into logical files
4. **Documented**: Comments explain non-obvious choices
5. **Practical**: Balances purity with pragmatism (e.g., Homebrew for GUI apps)

## Contributing

When making changes:
1. Test locally with `darwin-rebuild build` first
2. Commit with descriptive messages
3. Keep user-specific info in [me.nix](me.nix) and [secrets.nix](secrets.nix)
4. Document significant changes

## License

This configuration is provided as-is for personal use. Adapt it to your needs.
