# Dotfiles Command Reference and Style Guide

## Common Commands
- `./install.sh`: Install dotfiles using GNU stow
- `./sync-bin.sh`: Sync binaries to ~/bin
- `shellcheck <script.sh>`: Lint shell scripts
- `golangci-lint run`: Lint Go code
- `yamllint <file.yml>`: Lint YAML files
- `pre-commit run`: Run pre-commit hooks on staged files
- `pre-commit run --all-files`: Run hooks on all files

## Code Style
- Shell scripts: 2-space indentation, shellcheck compliance
- Vim: shiftwidth=2, tabstop=2, expandtab
- Git commit messages: Brief (<50 chars) summary, then blank line, then details
- Shell aliases: Use descriptive names in lowercase
- Functions: Use snake_case for shell functions
- Error handling: Always check command return values in scripts

## Environment
- Uses Homebrew for package management (see Brewfile)
- Supports both macOS and Linux distributions
- RStudio configurations for R development
- Neovim/Vim configurations for text editing
- Customized shell environment (zsh)