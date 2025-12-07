# core.nix

Opinionated core Nix configuration modules for macOS using nix-darwin and home-manager.

This repository provides reusable, modular configurations for common development tools and system settings. It's designed to be imported as a flake input into your personal dotfiles repository.

## Architecture

This is a **base configuration repository** that exports two module sets:

- `nix-darwin` - System-level configuration (fonts, homebrew, security)
- `home-manager` - User-level configuration (CLI tools, editors, shells)

The modules are tool-specific and live in individual directories, making them easy to understand, maintain, and selectively override.

## Structure

```
core.nix/
├── flake.nix                      # Exports nix-darwin and home-manager
├── home-manager/
│   ├── default.nix                # Imports all home-manager modules
│   ├── direnv/                    # direnv configuration
│   ├── gh/                        # GitHub CLI
│   ├── git/                       # Git configuration
│   ├── gnupg/                     # GPG agent setup
│   ├── jq/                        # JSON processor
│   ├── neovim/                    # Neovim editor
│   ├── starship/                  # Starship prompt
│   ├── tmux/                      # Terminal multiplexer
│   └── zsh/                       # Zsh shell
└── nix-darwin/
    ├── default.nix                # Imports all nix-darwin modules
    ├── fonts/                     # Font packages
    ├── homebrew/                  # Homebrew setup
    ├── security/                  # Security settings
    └── system/                    # System preferences
```

## Included Configurations

### Home Manager Modules

- **direnv** - Automatic environment loading
- **gh** - GitHub CLI
- **git** - Git with sensible defaults (no personal info)
- **gnupg** - GPG agent with SSH support
- **jq** - JSON command-line processor
- **neovim** - Modern Vim editor
- **starship** - Cross-shell prompt
- **tmux** - Terminal multiplexer with sensible settings
- **zsh** - Z shell with history and completion

### Nix-Darwin Modules

- **fonts** - Programming fonts (FiraCode, JetBrains Mono, etc.)
- **homebrew** - Basic homebrew setup
- **security** - macOS security settings
- **system** - Nix daemon and system defaults

## Usage

### As a Flake Input

Add to your dotfiles `flake.nix`:

```nix
{
  inputs = {
    core.url = "github:qmx/core.nix";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { core, nixpkgs-unstable, nixpkgs-stable, home-manager, nix-darwin, ... }:
  let
    system = "aarch64-darwin";
    # Use mkPkgs helper to get pkgs and pkgs-stable
    corePkgs = core.lib.mkPkgs {
      inherit system nixpkgs-unstable nixpkgs-stable;
    };
  in {
    # System configuration
    darwinConfigurations."hostname" = nix-darwin.lib.darwinSystem {
      modules = [
        core.nix-darwin           # Base configuration
        ./modules/nix-darwin      # Your overrides
        ./hosts/hostname/nix-darwin
      ];
    };

    # User configuration
    homeConfigurations."username" = home-manager.lib.homeManagerConfiguration {
      modules = [
        core.home-manager         # Base configuration
        ./modules/home-manager    # Your overrides
        ./hosts/hostname/home-manager
      ];
      extraSpecialArgs = {
        pkgs-stable = corePkgs.pkgs-stable;
      };
    };
  };
}
```

### Helper Functions

#### `core.lib.mkPkgs`

Creates package sets for a given system. Returns `{ pkgs, pkgs-stable }`.

- `pkgs` - From your nixpkgs-unstable input
- `pkgs-stable` - From your nixpkgs-stable input

```nix
corePkgs = core.lib.mkPkgs {
  system = "aarch64-darwin";  # or "x86_64-linux", etc.
  inherit nixpkgs-unstable nixpkgs-stable;  # your flake inputs
};

# Use in modules via extraSpecialArgs:
extraSpecialArgs = {
  pkgs-stable = corePkgs.pkgs-stable;
};
```

**Note**: Both `nixpkgs-unstable` and `nixpkgs-stable` parameters are required. This allows you to control all nixpkgs versions from your dotfiles flake, keeping version pinning decisions in one place.

### Local Development

For local development before publishing:

```nix
core.url = "git+file:../core.nix";
```

Update after making changes:

```bash
cd core.nix
git commit -m "Update configuration"

cd ../dotfiles
nix flake update core
```

## Customization

These modules provide sensible defaults without personal information. Override them in your dotfiles:

**Example**: Adding personal git config

```nix
# your-dotfiles/modules/home-manager/default.nix
{ ... }: {
  programs.git.settings = {
    user = {
      name = "Your Name";
      email = "you@example.com";
    };
    commit.gpgsign = true;
  };
}
```

## Design Principles

- **No personal data**: No usernames, emails, or signing keys
- **Modular**: Each tool in its own directory
- **Overridable**: Easy to customize in downstream configs
- **Opinionated**: Sensible defaults that work well together
- **Minimal**: Only essential configuration

## Requirements

- macOS (tested on Apple Silicon)
- Nix with flakes enabled
- nix-darwin
- home-manager

---

*Based on the modular configuration pattern from [Jitsusama's core.nix](https://github.com/Jitsusama/core.nix).*
