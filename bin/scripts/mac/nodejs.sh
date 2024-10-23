#!/bin/bash

pre_install() {
  if command -v node &> /dev/null; then
    echo "[INFO] Node.js is already installed. Skipping ..."
    return 1
  else
    return 0
  fi
}

post_install() {
  if command -v node &> /dev/null; then
    echo "[INFO] Installed Node.js successfully"
    return 0
  else
    echo "[ERROR] Installation of Node.js was not successful"
    exit 1
  fi
}

install() {
  echo "[INFO] Attempting to install Node.js ..."
  pre_install
  if [ $? -eq 0 ]; then
    # Install Node.js using Homebrew
    if ! command -v brew &> /dev/null; then
      echo "[INFO] Homebrew is not installed. Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install node
    post_install
    return 0
  fi
}
