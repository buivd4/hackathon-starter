#!/bin/bash

# Function to check if Docker is already installed
pre_install() {
  if command -v docker &> /dev/null; then
    echo "[INFO] Docker is already installed. Skipping ..."
    return 1
  else
    return 0
  fi
}

# Function to validate Docker installation
post_install() {
  if command -v docker &> /dev/null; then
    echo "[INFO] Installed Docker successfully"
    return 0
  else
    echo "[ERROR] Installation of Docker was not successful"
    exit 1
  fi
}

install() {
  # Main installation logic for macOS
  echo "[INFO] Attempting to install Docker ..."
  pre_install
  if [ $? -eq 0 ]; then
    # Check for Homebrew and install if not present
    if ! command -v brew &> /dev/null; then
      echo "[INFO] Homebrew is not installed. Installing Homebrew ..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install --cask docker
    post_install
    return 0
  fi
}