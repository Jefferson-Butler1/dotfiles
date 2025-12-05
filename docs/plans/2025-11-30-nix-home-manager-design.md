# Nix Home-Manager Cross-Platform Dev Environment

## Overview

Flakes-based Nix home-manager configuration managing dev environments across three machines: macbook (macOS), ryzen (Arch), silversurfer (Arch).

## Goals

- SSH from phone (Terminus) to Arch boxes via Tailscale
- Consistent dev tools: neovim nightly, fish, tmux, btop, lazygit, etc.
- Single source of truth for dotfiles
- Nix replaces stow for symlinking

## Repository Structure

```
dotfiles/
├── flake.nix
├── flake.lock
├── bootstrap.sh
│
├── hosts/
│   ├── macbook.nix
│   ├── ryzen.nix
│   └── silversurfer.nix
│
├── modules/
│   ├── dev-env.nix
│   ├── node.nix
│   └── darwin.nix
│
├── pkgs/
│   └── neovim-nightly.nix
│
├── tmux/
│   ├── .tmux.conf.darwin
│   └── .tmux.conf.linux
│
└── [existing configs unchanged]
    ├── nvim/.config/nvim/init.lua
    ├── fish/.config/fish/config.fish
    └── ...
```

## Module Composition

| Host | Modules |
|------|---------|
| macbook | dev-env, darwin |
| ryzen | dev-env, node |
| silversurfer | dev-env, node |

## Packages by Module

### dev-env.nix
- neovim (nightly, from source)
- fish, starship
- tmux
- git, lazygit, delta, gh
- fzf, ripgrep, fd, bat, eza, tree
- btop, jq, yq, tldr, stow, mosh

### node.nix
- kubectl, k9s, helm, fluxcd, kubectx

### darwin.nix
- macOS-specific settings (minimal for now)

## Key Decisions

1. **Flakes-based** - Modern Nix, better reproducibility
2. **Symlink existing configs** - No rewrite of init.lua, config.fish, etc.
3. **Neovim from source** - Custom derivation using flake input
4. **Split tmux configs** - Separate darwin/linux files for clipboard and shell path
5. **Bootstrap script** - One command to set up fresh Arch box

## Workflow

```bash
# Apply config
home-manager switch --flake .#jeff@<host>

# Update neovim to latest nightly
nix flake update neovim-src
home-manager switch --flake .#jeff@<host>

# Bootstrap new Arch box
curl -sL <raw-url>/bootstrap.sh | bash -s -- ryzen
```

## Future Considerations

- WireGuard migration (replace Tailscale)
- Additional modules as needed (media tools, etc.)
