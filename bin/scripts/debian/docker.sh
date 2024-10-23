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
  # Main installation logic for Debian
  echo "[INFO] Attempting to install Dockerc ..."
  pre_install
  if [ $? -eq 0 ]; then
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
    sudo apt-get update
    sudo apt-get install -y docker-ce
    post_install
    return 0
  fi
}
