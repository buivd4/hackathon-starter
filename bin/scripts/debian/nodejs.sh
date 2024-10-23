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
    # Update package list and install Node.js
    sudo apt update
    sudo apt install -y nodejs npm
    post_install
    return 0
  fi
}

# Call the install function to start the process
install