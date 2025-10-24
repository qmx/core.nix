# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a modular Nix flake that exports reusable configuration modules for macOS systems using nix-darwin and home-manager. It's designed to be imported as an input into personal dotfiles repositories, providing opinionated base configurations without personal data.

## Architecture

The repository exports two module sets via `flake.nix`:
- `nix-darwin` - System-level configurations (fonts, homebrew, security, system settings)
- `home-manager` - User-level configurations (CLI tools, editors, shells)

**Key architectural principles:**
1. **Module isolation**: Each tool lives in its own directory under `home-manager/` or `nix-darwin/`
2. **No personal data**: Configurations contain no usernames, emails, GPG keys, or signing keys
3. **Aggregation pattern**: `default.nix` files in each directory import all subdirectory modules
4. **Downstream overrides**: Configurations are intentionally minimal to allow users to override in their dotfiles

## Module Structure

Each module directory contains a `default.nix` that:
- Enables the tool via home-manager or nix-darwin options
- Sets sensible defaults
- Avoids personal configuration

Example structure:
```
home-manager/git/default.nix  - Enables git with basic settings
nix-darwin/fonts/default.nix  - Installs programming fonts
```

## Development Commands

### Testing Changes Locally

When testing changes before publishing, use in a downstream dotfiles repository:

```nix
# In your dotfiles flake.nix
inputs.core.url = "git+file:../core.nix";
```

### Updating in Downstream Repos

After making changes to this repository:

```bash
# In core.nix directory
git add .
git commit -m "description"

# In your dotfiles directory
nix flake lock --update-input core
```

### Building and Validating

```bash
# Check flake structure
nix flake show

# Check flake for errors
nix flake check
```

## Configuration Philosophy

**What belongs in this repo:**
- Tool installation and basic enablement
- Sensible defaults that work across environments
- General-purpose settings (e.g., git default branch, editor choice)

**What belongs in downstream dotfiles:**
- Personal information (names, emails, signing keys)
- Host-specific configurations
- Personal preferences that override defaults

## Important Notes

- Git default branch is set to `master` in home-manager/git/default.nix:11
- Neovim is set as the default editor
- Experimental features `nix-command` and `flakes` are enabled in nix-darwin/system/default.nix:6
- Each module should be self-contained and importable independently
