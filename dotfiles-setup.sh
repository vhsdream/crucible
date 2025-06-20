#!/usr/bin/env bash

ORIGINAL_DIR=$(pwd)
REPO_URL="https://gitlab.com/cnose/dotfiles.git"
REPO_NAME="dotfiles"

is_stow_installed() {
  pacman -Qi "stow" &>/dev/null
}

if ! is_stow_installed; then
  echo "Install stow first"
  exit 1
fi

cd ~

# Check if the repository already exists
if [ -d "$REPO_NAME" ]; then
  echo "Repository '$REPO_NAME' already exists. Skipping clone"
else
  git clone "$REPO_URL"
fi

# Check if the clone was successful
if [ $? -eq 0 ]; then
  cd "$REPO_NAME"
  stow starship
  stow yazi
  stow nvim
  stow lazygit
else
  echo "Failed to clone the repository."
  exit 1
fi
